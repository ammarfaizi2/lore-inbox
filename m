Return-Path: <linux-kernel-owner+w=401wt.eu-S1753773AbWLPU3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbWLPU3M (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 15:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753778AbWLPU3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 15:29:12 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:43018 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753773AbWLPU3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 15:29:11 -0500
Date: Sat, 16 Dec 2006 21:28:24 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lee Revell <rlrevell@joe-job.com>
cc: =?ISO-8859-1?Q?Hans-J=FCrgen?= Koch <hjk@linutronix.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
In-Reply-To: <1166300032.17059.4.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0612162124250.5411@yvahk01.tjqt.qr>
References: <20061213195226.GA6736@kroah.com>  <Pine.LNX.4.64.0612131252300.5718@woody.osdl.org>
  <200612140949.43270.duncan.sands@math.u-psud.fr>  <200612141056.03538.hjk@linutronix.de>
  <Pine.LNX.4.61.0612141756110.12730@yvahk01.tjqt.qr> <1166300032.17059.4.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 16 2006 15:13, Lee Revell wrote:
>On Thu, 2006-12-14 at 18:02 +0100, Jan Engelhardt wrote:
>> 
>> They use floating point in (Windows) kernelspace? Oh my.
>
>Yes, definitely.

Explains why Windows is so slow ;-) [FPU restore and stuff...]

On that matter, when does the Linux kernel do proper FPU handling? At context
switches? If so, would not that make a kthread fpu-capable?

>For example lots of Windows sound drivers do AC3 decoding in kernelspace.
>Of course the vendors usually lie and say it's done in hardware...

They don't need to lie, the user buys it anyway...


	-`J'
-- 
