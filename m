Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275963AbRJHSVA>; Mon, 8 Oct 2001 14:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276231AbRJHSUu>; Mon, 8 Oct 2001 14:20:50 -0400
Received: from mail213.mail.bellsouth.net ([205.152.58.153]:60138 "EHLO
	imf13bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S275963AbRJHSUk>; Mon, 8 Oct 2001 14:20:40 -0400
Subject: Re: linux-2.4.10-acX
From: Louis Garcia <louisg00@bellsouth.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15qeo4-0001MW-00@the-village.bc.nu>
In-Reply-To: <E15qeo4-0001MW-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 08 Oct 2001 14:21:54 -0400
Message-Id: <1002565315.8915.1.camel@tiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has raw/block I/O changes from linus 2.4.10 been merged?

Louis

On Mon, 2001-10-08 at 14:07, Alan Cox wrote:
> > Has Alan's tree been fully merged with Linus's?? Or are their bits in
> > Linus's tree that is not in Alan's?
> 
> There are measurable differences between the two trees. Notably
> 
> -	Linus uses the Andrea VM in 2.4.10
> 	-ac uses the Riel VM in 2.4.10-ac
> 
> The -ac tree also has the following major additions
> 
> -	Platform support for x86_64, usermode linux , etc
> -	32bit uid safe quota
> -	Ext3 file system
> -	PnPBIOS support
> -	Various PPro and Pentium workarounds
> -	Simple boot flag
> -	Faster x86 syscall path
> -	PPPoATM
> -	Elevator flow control
> -	DRM 4.0 and 4.1 support not just 4.1 (ie XFree 4.0.x works)
> -	CMS file system
> -	Intermezzo file system
> -	isofs compression
> 
> and drivers for
> 
> -	IB700
> -	IBM Mwave 
> -	Lots more MTD devices
> -	SA1100 PCMCIA
> -	Various USB toys
> 
> and then lots of bug fixes
> 
> Much of that will go on to Linus. Some he has refused (faster syscall path,
> elevator flow control, ..). It takes time to feed stuff on and often I want
> to test it in -ac first. Because so much changed in 2.4.10/11pre it's now
> getting very hard to merge a lot of the fixes like the truncate standards
> compliance stuff so they may not make Linus tree until 2.5
> 
> 
> Alan



