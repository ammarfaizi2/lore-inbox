Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262944AbVG3F54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262944AbVG3F54 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 01:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbVG3F54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 01:57:56 -0400
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:695 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262944AbVG3F5n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 01:57:43 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: isa0060/serio0 problems -WAS- Re: Asus MB and 2.6.12 Problems
Date: Sat, 30 Jul 2005 00:57:36 -0500
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, mkrufky@m1k.net, frank.peters@comcast.net,
       vojtech@suse.cz
References: <20050624113404.198d254c.frank.peters@comcast.net> <42EAF885.40008@m1k.net> <20050729213724.01c61c26.akpm@osdl.org>
In-Reply-To: <20050729213724.01c61c26.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200507300057.36921.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 July 2005 23:37, Andrew Morton wrote:
> 
> The diff between 2.6.12-rc4-mm2 and 2.6.12-rc5-mm1 is enormous, but there
> aren't any significant input driver changes there:
> http://www.zip.com.au/~akpm/linux/patches/stuff/diffstat-2.6.12-rc4-mm2-2.6.12-rc5-mm1
> 

>From the original thread it seems that the usual suspects (input and
ACPI updates) were not causing the failure, at leat not directly:

> >>I applied bk-input.patch directly to 2.6.12-rc5, and it did NOT break it 
> >>this time.  Looks like either a different patch is the culprit, or the 
> >>combination of this patch and another.
> >>
> >>    
> >>
> >
> >Please try adding bk-acpi to the mix.
> >
> >  
> >
> Combination of both bk-input and bk-acpi applied to 2.6.12-rc5 still 
> doesn't break it.  What next?

Some other patch must be messing things up somehow...

-- 
Dmitry
