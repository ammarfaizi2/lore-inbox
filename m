Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265317AbRF0RWr>; Wed, 27 Jun 2001 13:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265319AbRF0RWh>; Wed, 27 Jun 2001 13:22:37 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56580 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265317AbRF0RWW>; Wed, 27 Jun 2001 13:22:22 -0400
Subject: Re: Patch(2.4.5): Fix PCMCIA ATA/IDE freeze (w/ PCI add-in cards)
To: andre@aslab.com (Andre Hedrick)
Date: Wed, 27 Jun 2001 18:21:59 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        Gunther.Mayer@t-online.de (Gunther Mayer),
        linux-kernel@vger.kernel.org, dhinds@zen.stanford.edu
In-Reply-To: <Pine.LNX.4.04.10106270927070.21460-100000@mail.aslab.com> from "Andre Hedrick" at Jun 27, 2001 09:54:06 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FJ0p-0005XC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> obsoleting ATA-2 did their attention at CFA become alarmed.  I agree that
> there needs to be a fix, but not at the price of locking the rest of the
> driver.  Since we now the identity of the device prior to assigned the
> interrupt we can handle the execption, but you do not go around blanket
> wacking the control register of all devices.

I dont see why it locks up the driver ?


