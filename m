Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263133AbTIVMgW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 08:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbTIVMgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 08:36:22 -0400
Received: from [62.241.33.80] ([62.241.33.80]:47364 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263133AbTIVMfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 08:35:50 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: weez@freelists.org, linux-kernel@vger.kernel.org
Subject: Re: DAC960: Bad Data Block Found
Date: Mon, 22 Sep 2003 14:31:18 +0200
User-Agent: KMail/1.5.3
References: <200309211930.25350.weez@freelists.org>
In-Reply-To: <200309211930.25350.weez@freelists.org>
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200309221427.47215.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 September 2003 02:30, John Madden wrote:

Hi John,

> If there's some place better to post this, please let me know.  Since the
> DAC960 driver has been orphaned, I haven't heard of anyone stepping up to
> take it over, so I don't know where to go for help other than
> linux-kernel.

well, take a look at: http://www.osdl.org/archive/dmo/DAC960/

I use that driver for some months now w/o any problems at all where 2.4.11 
driver version has some problems. I use these controllers:

- Mylex DAC1164P PCI RAID Controller, 64MB cache
- Mylex DAC960PTL1 PCI RAID Controller, 8MB cache

> DAC960#0: Error Condition MEDIUM ERROR on READ:
> DAC960#0:   /dev/rd/c0d0:   absolute blocks 405095..405102
> DAC960#0:   /dev/rd/c0d0p1: relative blocks 405032..405039
> DAC960#0: Error Condition MEDIUM ERROR on READ:
> DAC960#0:   /dev/rd/c0d0:   absolute blocks 405095..405102
> DAC960#0:   /dev/rd/c0d0p1: relative blocks 405032..405039
> DAC960#0: Logical Drive 0 (/dev/rd/c0d0) Bad Data Block Found
> DAC960#0: Logical Drive 0 (/dev/rd/c0d0) Bad Data Block Found
> DAC960#0: Logical Drive 0 (/dev/rd/c0d0) Bad Data Block Found
> Sounds bad, but the drives are still ticking and I haven't noticed any fs
> corruption.  How serious is the error?  Can it be ignored?  Is it time to
> move to another array?  Would dropping everything, scrubbing, and
> restoring be sufficient?

hmm, never saw those messages. Already fsck -f'ed? Anyway, those messages 
would scare me :)

ciao, Marc


