Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267256AbTGLCQX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 22:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267261AbTGLCQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 22:16:23 -0400
Received: from home.wiggy.net ([213.84.101.140]:21136 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S267256AbTGLCQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 22:16:22 -0400
Date: Sat, 12 Jul 2003 04:31:05 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030712023105.GC3116@wiggy.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030711140219.GB16433@suse.de> <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Alan Cox wrote:
> On Gwe, 2003-07-11 at 15:02, Dave Jones wrote:
> > - Older Direct Rendering Manager (DRM) support (For XFree86 4.0)
> >   has been removed. Upgrade to XFree86 4.1.0 or higher.
> 
> The current 2.5 DRM doesnt seem to work with 4.1, but does with  4.3 at
> least on my testing of i810. I need to double check the results unless
> others see the same

If memory servers me correctly at least the XFree86 4.3.0 radeon driver
want a newer version of the kernel DRM modules than is present in
current 2.5. Unfortunately the code from the last DRI snapshot does not
seem to compile with 2.5.74 (haven't tried 2.5.75 yet).

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>      It is simple to make things.
http://www.wiggy.net/                     It is hard to make things simple.

