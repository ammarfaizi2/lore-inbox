Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313179AbSEVM4n>; Wed, 22 May 2002 08:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313183AbSEVM4l>; Wed, 22 May 2002 08:56:41 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6928 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313179AbSEVM4j>; Wed, 22 May 2002 08:56:39 -0400
Subject: Re: Orinoco Wireless driver bugs in 2.5.17
To: hermes@gibson.dropbear.id.au (David Gibson)
Date: Wed, 22 May 2002 14:16:41 +0100 (BST)
Cc: peter@chubb.wattle.id.au (Peter Chubb), linux-kernel@vger.kernel.org
In-Reply-To: <20020522015305.GJ4745@zax> from "David Gibson" at May 22, 2002 11:53:05 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AVyr-0001c5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've had one similar report, on a vaguely similar PCI<->PCMCIA
> bridge.  It looks very much as if we're not receiving any interrupts.
> That would appear to be a low-level problem with routing of interrupts
> through the bridge.  It may well be a PCMCIA subsystem problem rather
> than a driver problem.

The Compaq WL1xx orinoco simply doesn't work on 2.4.18 anyway. The older
driver works, the newer one fails totally.
