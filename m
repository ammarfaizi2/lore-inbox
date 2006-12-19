Return-Path: <linux-kernel-owner+w=401wt.eu-S932573AbWLSOrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbWLSOrR (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 09:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932819AbWLSOrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 09:47:17 -0500
Received: from nz-out-0506.google.com ([64.233.162.232]:64144 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932573AbWLSOrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 09:47:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=h4/HD06ECbJlm95dQfNCL+R/KxbZgigAiTL70RDBtpszLubM9cCOuxe+RujLWkYGrNmmeEYVStll3ua8jRphL1ERKR+x2vRYDGsTrTDqWbU9AQ7qUJ2piXO/YbEXD60vunhn79FaQalngCkZDZGnq5ct170lJNteu+QIIr7aw9w=
Message-ID: <4587FB6C.8080309@gmail.com>
Date: Tue, 19 Dec 2006 23:47:08 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: Harald Dunkel <harald.dunkel@t-online.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18.3, sata dvd writer: can't watch dvd
References: <45805C96.5090709@t-online.de>
In-Reply-To: <45805C96.5090709@t-online.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arald Dunkel wrote:
> Hi folks,
> 
> I've got a shiny new sata dvd writer: A Samsung SH-183A,
> most recent firmware SB01. Writing data DVDs is _lightning_
> fast, but I cannot watch my css-encrypted movie DVDs, even
> with libdvdcss installed. If I try, then it becomes
> unresponsive. dmesg says:
> 
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: (BMDMA stat 0x1)
> ata2.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
> ata2: soft resetting port
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata2.00: failed to IDENTIFY (device reports illegal type, err_mask=0x0)
> ata2.00: revalidation failed (errno=-22)
> ata2.00: disabled
> ata2: EH complete
> Buffer I/O error on device sr0, logical block 0
> Buffer I/O error on device sr0, logical block 1
> Buffer I/O error on device sr0, logical block 2
> Buffer I/O error on device sr0, logical block 3
> Buffer I/O error on device sr0, logical block 4
> Buffer I/O error on device sr0, logical block 5
> Buffer I/O error on device sr0, logical block 6
> Buffer I/O error on device sr0, logical block 7
> Buffer I/O error on device sr0, logical block 0
> Buffer I/O error on device sr0, logical block 1
> 
> After that the DVD drive is dead, waiting for a reset.
> I tried this with 4 DVDs by now.
> 
> Watching my own DVD-Rs (created in a Philips HD recorder),
> or commercial DVDs without CSS (e.g. "True Lies") is no
> problem. The region code is set (2), of course.
> 
> 
> Any idea? Unfortunately I cannot verify the drive in a
> proprietary runtime environment.

If you use mplayer, please run it with '-v' and report what it says.
Also, full dmesg will help.

-- 
tejun
