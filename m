Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265423AbSKVXvb>; Fri, 22 Nov 2002 18:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265446AbSKVXvb>; Fri, 22 Nov 2002 18:51:31 -0500
Received: from magic.adaptec.com ([208.236.45.80]:20636 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S265423AbSKVXva>; Fri, 22 Nov 2002 18:51:30 -0500
Date: Fri, 22 Nov 2002 16:57:57 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Bill Gardner <bgardner@transzap.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx driver error at boot for Adaptec AIC-7899P U160
Message-ID: <239635408.1038009477@aslan.btc.adaptec.com>
In-Reply-To: <CA3FD75251B0CE43B9B6CA87786E2E4307B37D@tzi.transzap.com>
References: <CA3FD75251B0CE43B9B6CA87786E2E4307B37D@tzi.transzap.com>
X-Mailer: Mulberry/3.0.0a5 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello!
> 
> We are seeing some strange errors at boot time from the aic7xxx driver.
> 
> Relevant HW/SW Info:
> 
>    Host: Racksaver (Model: RS-1129) with dual AMD Athlon(tm) MP 2100+
> cpu's    Motherboard: Tyan S2468 with an onboard Adaptec AIC-7899P U160/m
> (rev 01). 
>    Dist: Redhat 7.3
>    Kernel: Linux version 2.4.18-3smp (bhcompile@porky.devel.redhat.com) 
>       (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 SMP Thu
> Apr 18 06:59:55 EDT 2002
> 
> Relevant Console errors:
> 
>    scsi0:0:0:0: Attempting to queue an ABORT message
>    scsi0: Dumping Card State while idle, at SEQADDR 0x44
> 
>    ...whole bunch of aic7xxx dump messages (see below for complete list)
> 
>    scsi0:0:0:0: Command already completed
>    aic7xxx_abort returns 0x2002

Interrupts are not being routed correctly on your system.  There's
not much the aic7xxx driver can do if interrupts don't work.  One
of the Linux PCI wizards might be able to help you.

--
Justin
