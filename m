Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266344AbUIOGSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUIOGSe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 02:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUIOGSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 02:18:34 -0400
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:51396 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266344AbUIOGSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 02:18:30 -0400
To: linux-kernel@vger.kernel.org
Date: Wed, 15 Sep 2004 08:18:25 +0200
From: Soeren Sonnenburg <kernel@nn7.de>
Message-ID: <pan.2004.09.15.06.18.23.771355@nn7.de>
Organization: Local Intranet News
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
References: <20040914160530.GA729@evilgeek.net>
Subject: Re: pdc202xx_new + software raid0 freezes on array writes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 16:05:30 +0000, Peter Mc Aulay wrote:

> Hi...
> 
> [NOTE: Please CC replies to me personally as I'm not a list subscriber.
> Thank you.]
> 
> I was wondering if anyone could help me at all with a little problem I'm
> having.
> 
> I have 4 Western Digital 200GB hard disks (WDC WD2000JB) in a software
> RAID0 setup, two each connected to a Promise Ultra100TX2 (PDC20268) and
> an Ultra133TX2 (PDC20269) (pdc202XX_new driver compiled into the
> kernel).  The system itself is a K6-2 450Mhz CPU on an ATX mainboard of
> unknown brand using the ALi M1541/5229 chipset (ALI15X3).  It boots from
> a seperate Seagate (ST38410A) hard disk connected to the on-board
> controller.

I had the very same problems with the pdc20268 and also reported them
(that was 1-2 years ago)... I threw them away now and replaced them with
some hpt370 controllers... then also the problems went away...

However I found that using some device on the secondary controller and
accessing that one makes it freeze already...

Soeren
