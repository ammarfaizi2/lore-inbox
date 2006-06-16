Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWFPWHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWFPWHa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 18:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWFPWHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 18:07:30 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:37092 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751018AbWFPWH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 18:07:29 -0400
Date: Sat, 17 Jun 2006 00:07:19 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: daniel+devel.linux.lkml@flexserv.de
cc: linux-kernel@vger.kernel.org
Subject: Re: Bug: XFS internal error XFS_WANT_CORRUPTED_RETURN
In-Reply-To: <87irn0zsqq.fsf@xserver.flexserv.de>
Message-ID: <Pine.LNX.4.61.0606170005150.27136@yvahk01.tjqt.qr>
References: <878xnx19bs.fsf@xserver.flexserv.de> <200606161835.26428.s0348365@sms.ed.ac.uk>
 <87irn0zsqq.fsf@xserver.flexserv.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Its an full equiped E420R 4*450Mhz 4GB RAM.
>I dont know  a memtesttool for sparcs.

Join the club, I am looking for one too.

Too bad that the Forth interpreter can only address a little less than 
640KB of memory (reminds me of DOS huh), otherwise I would have written a 
memchecker.

>If you know one please drop me a line.
>every test from obp runs fine.

There exists a userspace checker. It mlock()s a big chunk of memory and 
pokes on it like memtest86. It does not catch the few megabytes required 
for booting, but when you swap the upper half of the memory banks with the 
lower ones and rerun, you should get the same results of memtest86 would 
do.


Jan Engelhardt
-- 
