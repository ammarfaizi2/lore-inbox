Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263988AbUDFU3y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 16:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263996AbUDFU3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 16:29:54 -0400
Received: from out008pub.verizon.net ([206.46.170.108]:42904 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S263988AbUDFU3u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:29:50 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Joerg Sommrey <jo@sommrey.de>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: libusb scanner hangs with 2.6.x-mm kernels
Date: Tue, 6 Apr 2004 16:29:48 -0400
User-Agent: KMail/1.6
References: <20040406194708.GB13257@sommrey.de>
In-Reply-To: <20040406194708.GB13257@sommrey.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404061629.48925.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.9.226] at Tue, 6 Apr 2004 15:29:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 April 2004 15:47, Joerg Sommrey wrote:
>Hello,
>
>since 2.6.3-mm4 most of the mm-kernels cause a complete hang of
> libusb applications accessing my Epson perfection 1260 scanner. 
> Disabling hotplug (i.e. replacing /sbin/hotplug with /bin/true) 
> solved the problem on some kernels, on others this made my usb
> mouse unusable. Plain vanilla kernels and rc-series work fine. 
> There has been some discussion on this topic on the usb-developer's
> list.  I'm not sure if this problem is already addressed on the
> kernel mailing list.
>
>This problem prevents me from using mm-kernels.
>
>-jo

See the patch attached to one of my messages a few minutes ago, from 
David Brownell that I just posted back to this and the linux-usb 
lists.  That seems to fix it right up.  Its an attachment called 
Diff-xsane-hang now.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
