Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265067AbTFUByy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 21:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265069AbTFUByy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 21:54:54 -0400
Received: from msgbas1x.cos.agilent.com ([192.25.240.36]:43457 "EHLO
	msgbas1x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S265067AbTFUByx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 21:54:53 -0400
Message-ID: <334DD5C2ADAB9245B60F213F49C5EBCD05D551C3@axcs03.cos.agilent.com>
From: yiding_wang@agilent.com
To: linux-kernel@vger.kernel.org
Subject: 2.5.70/71 kernel compiler and loading issues
Date: Fri, 20 Jun 2003 20:08:53 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Team,

I also tried 2.5.70 kernel on the same system, the compiler error is the same (The message is "Unknown Pseudo-op:  '.incbin'").

Then I loaded these two kernels on another SuperMicro 2 PIII CPU system. It has RH Linux 9.0 (2.4.20-8) on it.  Both kernel compiled OK.  However, reboot with new kernel hung system at the point of:
Uncompressing Linux ... Ok, booting the kernel.

System boot won't proceed.  This happens to both 2.5.70 and 2.5.71.

The process of build and reboot new kernel is same as what I did for previous few kernel.  From 2.5.70 README file, this process doesn't seem to be changed.  I wonder someone may know the issue and have solution already.

Any help is appreciated!  Thanks!

Eddie

> -----Original Message-----
> From: WANG,YIDING (A-SanJose,ex1) 
> Sent: Friday, June 20, 2003 3:05 PM
> To: linux-kernel@vger. kernel. org (E-mail)
> Subject: Linux-2.5.71 kernel compile error
> 
> 
> Team,
> 
> I got failure on compiling the kernel in one of SuperMicro 
> signle CPU system.  It has a Linux 2.4.2 on it.  
> The message is "Unknown Pseudo-op:  '.incbin'"
> 
> The file brings the trouble is arch/i386/kernel/vsyscall.S.
> 
> I think it must be a configuration problem but don't know 
> which one is causing the trouble. I am using menuconfig to 
> change the configuration.
> 
> Any suggestion?
> 
> Thanks!
> 
> Eddie 
