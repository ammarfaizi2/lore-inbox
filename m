Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266937AbUBEWds (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 17:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266939AbUBEWds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 17:33:48 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:34940 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266937AbUBEWdZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 17:33:25 -0500
From: Murilo Pontes <murilo_pontes@yahoo.com.br>
To: LINUX KERNEL MAILING LIST <linux-kernel@vger.kernel.org>
Subject: Re: psmouse.c, throwing 3 bytes away
Date: Thu, 5 Feb 2004 19:33:47 +0000
User-Agent: KMail/1.6
References: <4022BC15.4090502@wanadoo.es>
In-Reply-To: <4022BC15.4090502@wanadoo.es>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402051933.47597.murilo_pontes@yahoo.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not problems only using kde-3.2! 
I have problems running any Window manager,

The problem is similar for "Kernel losing many ticks", 
I think which problem is in VM system, "Kernel losing many ticks" is worst case of
kernel wait(long) get data from disk without DMA, but this is solve by activing DMA for all disks.

The time service maybe depend "wait kernel VM flush", like flush g++ buffers 
or disk cache in systems with ~512MB without swap partitions. 
This long wait increase kernel jiffes is not suficient for cause "Kernel losing many ticks",
but is suficient for break fewer bytes in mouse stream data..... 

In parallel may be I2c/acpi thermal and fan monitoring software like gkrellm, well like S.M.A.R.T.
on disks, increase wait states in hardware. 
Anyone is take this BUG always which i2c/acpi thermal and fan/s.m.a.r.t. is off????

Thanks

Em Qui 05 Fev 2004 21:56, Luis Miguel García escreveu:
> It's only me or we're having problems with kde 3.2?? Does it make sense? 
> perhaps it's only that it's big compile? or not?
> 
> I have this problemsometimes and even another problem in which 
> double-click converts itself in 40-clicks.
> 
> Any tip on that?
> 
> 
> 
