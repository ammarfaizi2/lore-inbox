Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287414AbRL3Nod>; Sun, 30 Dec 2001 08:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287407AbRL3NoY>; Sun, 30 Dec 2001 08:44:24 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31751 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287406AbRL3NoM>; Sun, 30 Dec 2001 08:44:12 -0500
Subject: Re: [PATCH, COMPILE-FIX, TYPO] drivers/char/pc110pad.c
To: manfred@colorfullife.com (Manfred Spraul)
Date: Sun, 30 Dec 2001 13:54:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <3C2F138C.63EAAE71@colorfullife.com> from "Manfred Spraul" at Dec 30, 2001 02:15:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16KgQL-0001G3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The bug was introduced between 2.4.17 and 2.5.1: someone added
> spinlocks instead of cli(), without adding his name to the changelog.

It was broken as part of the weird cli -> spinlock patch that someone added.
I'd fixed it but there is no SMP PC110 so I never tested that case.

Alan
