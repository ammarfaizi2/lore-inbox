Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318706AbSHWIPb>; Fri, 23 Aug 2002 04:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318708AbSHWIPa>; Fri, 23 Aug 2002 04:15:30 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:59125 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318706AbSHWIPa>; Fri, 23 Aug 2002 04:15:30 -0400
Subject: Re: SMP Netfinity 340 hangs under 2.4.19
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Maurice Volaski <mvolaski@aecom.yu.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a05111608b98b96373cce@[129.98.90.227]>
References: <a05111608b98b96373cce@[129.98.90.227]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 23 Aug 2002 09:21:04 +0100
Message-Id: <1030090864.5932.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-23 at 08:58, Maurice Volaski wrote:
> A single processor Netfinity 340 running RedHat 7.1 and kernel 2.4.18 
> was recently upgraded to
> 
> 1) 1 GB RAM
> 2) second processor (1 Ghz Xeon)
> 3) 2.4.19 for SMP with bigmem and added NFS server patches and 
> ext3-related patches.

Exactly what patches ? and does unpatched 2.4.19 behave ?

> Is there significance to the fact that keyboard and mouse are frozen 
> but apparently some processes are still up?

Interrupts are running but its stuck looping in kernel space I suspect. 

