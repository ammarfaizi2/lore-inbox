Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbTIKOdh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 10:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbTIKOdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 10:33:37 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:35985 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261301AbTIKOde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 10:33:34 -0400
Subject: Re: Problem: IDE data corruption with VIA chipsets on
	2.4.20-19.8+others
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Eric Bickle <ebickle@healthspace.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <003601c37826$26d8d220$5d74ad8e@hyperwolf>
References: <003601c37826$26d8d220$5d74ad8e@hyperwolf>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063290726.2967.15.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Thu, 11 Sep 2003 15:32:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-09-11 at 06:32, Eric Bickle wrote:
> == during server runtime ==
> kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=150637065,
> sector=150636992

This is a physical failure from the hard disk *NOT* a Linux problem

> kernel: end_request: I/O error, dev 16:01 (hdc), sector 150636992
> kernel: hdc: dma_intr: status=0x53 { DriveReady SeekComplete Index Error }
> kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=150630007,
> sector=150629920

Ditto

So the only things you've posted here are physical drive failures.


