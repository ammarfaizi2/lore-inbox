Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269641AbUICL5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269641AbUICL5f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 07:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269643AbUICL5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 07:57:35 -0400
Received: from the-village.bc.nu ([81.2.110.252]:22931 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269641AbUICL5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 07:57:23 -0400
Subject: Re: PROBLEM: Full CPU-usage on sis5513-chipset disc
	input/output-operations
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hendrik Fehr <s4248297@rcs.urz.tu-dresden.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1094206957.413845ed84b54@rmc60-231.urz.tu-dresden.de>
References: <1094206957.413845ed84b54@rmc60-231.urz.tu-dresden.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094208914.7535.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 03 Sep 2004 11:55:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-03 at 11:22, Hendrik Fehr wrote:
> (note: i use ide0=ata66 because my machine is a laptop which uses a short 40c
> wire that is equal to an long (i thing 18 inches) 80c cable.)

That should be fine - if it was not you would get CRC errors.

> hda: 78140160 sectors (40007 MB), CHS=65535/16/63, UDMA(100)
> hda: cache flushes supported
>  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 >

This all looks fine

> hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)

Likewise. So it is booting up with DMA enabled and ought to be fast for
both devices. What does hdparm -t /dev/hda say ?

