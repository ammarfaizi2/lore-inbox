Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbWJBUSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWJBUSW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWJBUSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:18:22 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41882 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964965AbWJBUSV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:18:21 -0400
Subject: Re: [patch 2.6.18-git] ide-cs (CompactFlash) driver, rm irq warning
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Brownell <david-b@pacbell.net>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200610021158.59886.david-b@pacbell.net>
References: <200610020902.20030.david-b@pacbell.net>
	 <1159811149.8907.32.camel@localhost.localdomain>
	 <200610021158.59886.david-b@pacbell.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Oct 2006 21:43:32 +0100
Message-Id: <1159821812.8907.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-02 am 11:58 -0700, ysgrifennodd David Brownell:
> The IRQ handler seems to be drivers/ide/ide-io.c::ide_intr() and
> comments there reflect the expectation that it handle shared IRQs.

I was more worried what the pcmcia side may be up to but yes this should
get dealt with and -mm will find any horrors fast.

Acked-by: Alan Cox <alan@redhat.com>

