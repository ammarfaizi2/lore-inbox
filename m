Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbUL2Phx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUL2Phx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 10:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbUL2Phw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 10:37:52 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:37538 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261358AbUL2Pht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 10:37:49 -0500
Subject: Re: PATCH: 2.6.10 - IT8212 IDE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Blazejowski <diffie@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <9dda349204122821262f71e375@mail.gmail.com>
References: <9dda349204122821262f71e375@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104330829.30087.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 29 Dec 2004 14:33:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-12-29 at 05:26, Paul Blazejowski wrote:
> Alan,
> 
> This patch works here but the performance is very poor. When i set DMA
> and 32bit I/O thru hdparm, performance is comparable to the ITE pseudo
> SCSI driver.

32bit I/O won't matter. DMA does (but nothing else - the firmware does
DMA and the controller actually does the UDMA itself in RAID mode and
does not support fancy mode tuning via hdparm)

