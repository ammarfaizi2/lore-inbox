Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270797AbRH1L7U>; Tue, 28 Aug 2001 07:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270800AbRH1L7K>; Tue, 28 Aug 2001 07:59:10 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29198 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270797AbRH1L65>; Tue, 28 Aug 2001 07:58:57 -0400
Subject: Re: oops in 3c59x driver
To: paubert@iram.es (Gabriel Paubert)
Date: Tue, 28 Aug 2001 12:19:20 +0100 (BST)
Cc: wichert@wiggy.net (Wichert Akkerman), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0108271832320.580-100000@ltgp.iram.es> from "Gabriel Paubert" at Aug 27, 2001 06:52:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15bgtt-0005qS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > esi: c1e12812   edi: c5fd4870   ebp: c5fd4940   esp: c125be70
> > ds:  0018  es: 0078   ss: 0018
>              ^^^^^^^^
> You are another victim of the dubious segment reload optimizations...

Which are now fixed btw
