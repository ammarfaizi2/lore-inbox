Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbTEVUXr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 16:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263234AbTEVUXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 16:23:47 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:43998 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263219AbTEVUXq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 16:23:46 -0400
Date: Thu, 22 May 2003 22:36:20 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Peter <cogwepeter@cogweb.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: DMA gone on ALI 1533
In-Reply-To: <Pine.LNX.4.44.0305221240040.15298-100000@greenie.frogspace.net>
Message-ID: <Pine.SOL.4.30.0305222230220.26086-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 May 2003, Peter wrote:

> I had included kernel support for the ALI 15X3 chipset, but as a module --
> and it obviously didn't load. If I include the module in /etc/modules, it
> loads too late (details below). I'm assuming this means "make menuconfig"
> mistakenly provides the module option? I've recompiled it into the kernel

Module support for IDE chipsets is currently unfinished/broken.
Lot of things need fixing before we will have _correct_ module support.
If we won't manage to do it for 2.6, option for compiling them as
modules will backed out.

> and got DMA back (although only dma2, as before) -- thanks for the quick
> feedback!
>
> Cheers,
> Peter

Cheers,
--
Bartlomiej

