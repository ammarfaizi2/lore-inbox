Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbTLHBcR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 20:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265274AbTLHBcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 20:32:17 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:10430 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265170AbTLHBcQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 20:32:16 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Subject: Re: (2.6.0-test9) Disabling IDE DMA removes ability to select chipsets
Date: Mon, 8 Dec 2003 02:34:13 +0100
User-Agent: KMail/1.5.4
Cc: akpm@osld.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <16317.18125.869980.877589@wombat.disy.cse.unsw.edu.au>
In-Reply-To: <16317.18125.869980.877589@wombat.disy.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312080234.13314.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thursday 20 of November 2003 23:57, Peter Chubb wrote:
> Hi,
> 	In drivers/ide/Kconfig at present, if you deselect
> BLK_DEV_IDEDMA_PCI you can then *not* select any of the non-generic
> chipsets.  Thus you lose the ability to auto-tune PIO modes, for
> example.

Thats because otherwise you will have compile time hell.

--bart

