Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287311AbRL3CRd>; Sat, 29 Dec 2001 21:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287303AbRL3CRY>; Sat, 29 Dec 2001 21:17:24 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49413 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287310AbRL3CRF>; Sat, 29 Dec 2001 21:17:05 -0500
Subject: Re: AX25/socket kernel PATCHes
To: henk.de.groot@hetnet.nl (Henk de Groot)
Date: Sun, 30 Dec 2001 02:27:49 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20011230004059.00a2ac90@pop.hetnet.nl> from "Henk de Groot" at Dec 30, 2001 12:56:25 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16KVhV-0006bg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >                        if (skb2->nh.raw < skb2->data || skb2->nh.raw >= skb2->...

> +                       if (skb2->nh.raw < skb2->data || nh.raw > skb2->tail) {
Add: 							   skb2->

my fault

