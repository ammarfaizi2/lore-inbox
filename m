Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbTFPTgS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 15:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264197AbTFPTgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 15:36:18 -0400
Received: from sklave3.rackland.de ([213.133.101.23]:50404 "EHLO
	sklave3.rackland.de") by vger.kernel.org with ESMTP id S264192AbTFPTgP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 15:36:15 -0400
From: Hadmut Danisch <hadmut@danisch.de>
Date: Mon, 16 Jun 2003 21:49:24 +0200
To: linux-kernel@vger.kernel.org
Subject: VIA VT8366 and IDE/DMA?
Message-ID: <20030616194924.GA15602@danisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a K7 mainboard with VT8366 chipset, but I can't
turn IDE DMA on:

atlantis# hdparm -d1 /dev/hda

/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)


Writing to /proc/ide/ide0/hda/settings has no effect.


Can anyone give me a hint how to turn DMA on?

regards
Hadmut
