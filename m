Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTLLUzn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 15:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbTLLUzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 15:55:43 -0500
Received: from dci.doncaster.on.ca ([66.11.168.194]:30422 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261950AbTLLUzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 15:55:42 -0500
Subject: Re: 2.4.23 Boot failure
From: Danny Brow <fms@istop.com>
To: Kernel-Maillist <linux-kernel@vger.kernel.org>
In-Reply-To: <1071260218.13287.46.camel@bubbles.imr-net.com>
References: <1071260218.13287.46.camel@bubbles.imr-net.com>
Content-Type: text/plain
Message-Id: <1071262670.19921.1.camel@zeus.fullmotionsolutions.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 12 Dec 2003 15:57:50 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have this problem with an acer laptop, if you have apic selected you
will never get passed the uncompressing Linux screen. If you have frame
buffer support compiled in you could try to append vga=normal to lilo to
see if there are any errors.

Dan.

On Fri, 2003-12-12 at 15:16, Joshua Schmidlkofer wrote:
> 2.4.23 Hangs just after the boot loader.
> 
> This is what I get:
>  
> Uncompressing Linux... Ok, booting the kernel.
> 
> 
> Then nothing.   I have never seen this before.  I do not get any errors,
> it just hangs.  
> 
> I have been trying to upgrade my server from 2.4.20 to 2.4.23.  This
> server is running the xfs patches from SGI.
> 
> It is a Dual PIII 800
> 1.1GB Ram
> 
> Storage:
>    cpqarry - Compaq Smart Array 431 Controller
>      RAID5 array [5 disks.]
>    sym53c8xx
>      4 independent scsi disk - Boot drive here.
> 
> 
> Attached is my .config, 
> 
> Please let me know if there is anything else.  I have tried make
> mrproper, then rebuilding, and I have changed a few options, etc.
> 
> Note:  2.4.21, and 2.4.22 both started booting, but would hang on the
> sym53c8xx controller.  I did not devote time to the issue to sort it
> out.  I need to update because of the brk() vuln, and I would rather
> just move to 2.4.23.  
> 
> I am using 2.4.23 + xfs patches.
> 
> thanks,
>   Joshua

