Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbTEZTEm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 15:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbTEZTEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 15:04:42 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:55425 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262145AbTEZTEk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 15:04:40 -0400
Date: Mon, 26 May 2003 21:16:36 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE: fix "biostimings" and legacy chipsets' boot parameters
 interaction
In-Reply-To: <200305261814.h4QIEAV28934@devserv.devel.redhat.com>
Message-ID: <Pine.SOL.4.30.0305262111440.7018-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 May 2003, Alan Cox wrote:

> > IDE: fix "biostimings" and legacy chipsets' boot parameters interaction.
>
> I have to admit I don't care since biostimings is a stupid patch Linus
> forced into the tree against my wishes. Its a great way to lose all your
> data if you turn it on

You mean setting using_dma in ide_setup_dma() or comment in setup-pci.c?
If it is data risky, why not kill it? I will be very happy - one sucky
parameter less.
--
Bartlomiej

