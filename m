Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262824AbSLTRXg>; Fri, 20 Dec 2002 12:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262828AbSLTRXf>; Fri, 20 Dec 2002 12:23:35 -0500
Received: from milligan.cwx.net ([216.17.176.90]:55941 "EHLO mail.acmeps.com")
	by vger.kernel.org with ESMTP id <S262824AbSLTRXf>;
	Fri, 20 Dec 2002 12:23:35 -0500
Message-ID: <3E0353ED.6000101@acmeps.com>
Date: Fri, 20 Dec 2002 10:31:25 -0700
From: Michael Milligan <milli@acmeps.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021210 Debian/1.2.1-3
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Broken AGP initialization for i845G chipset [patch]
References: <3E025858.4000404@acmeps.com> <20021220102715.GE24782@suse.de>
In-Reply-To: <20021220102715.GE24782@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Thu, Dec 19, 2002 at 04:38:00PM -0700, Michael Milligan wrote:
>  > 
>  > Patch below.  Calls the 845 initialization function instead of the 830MP,
>  > and a small formatting cleanup.  This is verified working.
> 
> With testgart/some other AGP using app ?

Patched, It boots on my shiny new ASUS P4B533-VM motherboard with 
GeForce 4 TI 4200 AGP card.  Identifies the chipset properly and 
proceeds to boot fine.  X works (nvidia driver), OpenGL works.  Without 
patch, it hangs (the PCI bus I think) after AGP initialization.

> It looks totally logical. I'm just wondering if it was a cut-n-paste
> accident, or someone had a genuine reason for doing that in the
> first place.

I have no idea if the 830MP initialization is supposedly more compatible 
with the 845G chipset than the 845 initialization.  I just know it 
didn't work and took a guess as to what it should be.

Regards,
Mike

-- 
Michael Milligan  --  Free Agent  --  milli@acmeps.com

