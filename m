Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265868AbTL3WpK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265834AbTL3WoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:44:18 -0500
Received: from mail017.syd.optusnet.com.au ([211.29.132.168]:35559 "EHLO
	mail017.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264305AbTL3Wm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:42:29 -0500
Message-Id: <6.0.1.1.2.20031231063148.03f35ce8@wheresmymailserver.com>
X-Nil: 
Date: Wed, 31 Dec 2003 09:42:18 +1100
To: go@turbolinux.co.jp
From: Leon Toh <tltoh@attglobal.net>
Subject: Re: Adaptec/DPT I2O Option Omitted From Linux 2.6.0 Kernel
  Configuration Tool
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Go,

Thanks for the link. I'll give it a shot.


Date: Tue, 30 Dec 2003 12:32:51 +0900
From: Go Taniguchi <go@turbolinux.co.jp>
To: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Adaptec/DPT I2O Option Omitted From Linux 2.6.0 
Kernel   Configuration
  Tool

Hi,

Just FYI.

This is my patch.
http://pkgcvs.turbolinux.co.jp/~go/patch-2.6/dpt_i2o.patch

Worked fine for me on quad xeon with 4G mem and 64bit PCI.
It include.
- Support 2.6 kernel and DMA-mapping
- ioctl fix for raid tools
- use schedule_timeout in long long loop
- not support 64bit CPU yet.

However, It may differ from the Adaptec policy (linux-scsi ML).

Samuel Flory wrote:
 > Samuel Flory wrote:
 >
 >>
 >>   You might want to hold off on doing a lot of work for a bit.  I
 >> think there was a beta driver that was being passed around.
 >>
 >
 >   FYI I've found a beta release of the dpt-i2o driver that someone sent
 > me.  I'll see if I can figure out what the current status of it.
 >

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

