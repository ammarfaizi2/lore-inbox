Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281437AbRKEXup>; Mon, 5 Nov 2001 18:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281440AbRKEXue>; Mon, 5 Nov 2001 18:50:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62725 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281439AbRKEXuT>; Mon, 5 Nov 2001 18:50:19 -0500
Subject: Re: PCI interrupts
To: matt@eee.nott.ac.uk (Matthew Clark)
Date: Mon, 5 Nov 2001 23:57:27 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.OSF.4.31.0111052332160.25619-100000@perry> from "Matthew Clark" at Nov 05, 2001 11:43:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E160tcN-00078L-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In my development system the PCI card I am developing  the
> driver for reports (from the PCI config region) that it is using
> interrupt 5.  I can't register this interrupt as it is already
> in use by the USB controller.

PCI interrupts are shared, and must be sharable. Generally the bus wiring
determines what gets shared
