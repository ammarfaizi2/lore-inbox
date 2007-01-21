Return-Path: <linux-kernel-owner+w=401wt.eu-S1751669AbXAUVc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbXAUVc6 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 16:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbXAUVc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 16:32:57 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:52127 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbXAUVc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 16:32:57 -0500
Date: Sun, 21 Jan 2007 22:31:25 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ralf Baechle <ralf@linux-mips.org>
cc: sathesh babu <sathesh_edara2003@yahoo.co.in>, linux-mips@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: Re: Running Linux on FPGA
In-Reply-To: <20070121001457.GA9123@linux-mips.org>
Message-ID: <Pine.LNX.4.61.0701212228340.29213@yvahk01.tjqt.qr>
References: <20070120234237.49126.qmail@web7912.mail.in.yahoo.com>
 <20070121001457.GA9123@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 21 2007 00:14, Ralf Baechle wrote:
>On Sat, Jan 20, 2007 at 11:42:37PM +0000, sathesh babu wrote:
>
>>   I am trying to run Linux-2.6.18.2 ( with preemption enable)
>>   kernel on FPGA board which has MIPS24KE processor runs at 12
>>   MHZ. Programmed the timer to give interrupt at every 10msec. I
>>   am seeing some inconsistence behavior during boot up processor.
>>   Some times it stops after "NET: Registered protocol family 17"
>>   and "VFS: Mounted root (jffs2 filesystem).". Could some give
>>   some pointers why the behavior is random. Is it OK to program
>>   the timer to 10 msec? or should it be more.
>
>The overhead of timer interrupts at this low clockrate is
>significant so I recommend to minimize the timer interrupt rate as
>far as possible. This is really a tradeoff between latency and
>overhead and matters much less on hardcores which run at hundreds of
>MHz.

Hm I've been running 2.6.13 on a 10/20 MHz (switchable) i386 @ 100 Hz
before without any hangs during boot or operation.


	-`J'
-- 
