Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276585AbRJKRKW>; Thu, 11 Oct 2001 13:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276558AbRJKRKN>; Thu, 11 Oct 2001 13:10:13 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14085 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276369AbRJKRJ7>; Thu, 11 Oct 2001 13:09:59 -0400
Subject: Re: eepro100.c bug on 10Mbit half duplex (kernels 2.4.5 / 2.4.10 / 2.4.11pre6 / 2.4.11 / 2.4.10ac11)
To: robbert@radium.jvb.tudelft.nl (Robbert Kouprie)
Date: Thu, 11 Oct 2001 18:15:54 +0100 (BST)
Cc: jgluckca@home.com ('John Gluck'), linux-kernel@vger.kernel.org
In-Reply-To: <002601c15275$2945b510$020da8c0@nitemare> from "Robbert Kouprie" at Oct 11, 2001 06:52:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15rjR4-000400-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> files. It would always lockup after said amount of traffic, but only in
> 10 Mbit half duplex mode. Also, I have the 82557, not the 82558 chip.
> 
> The problem looks a lot like what should be fixed in this changelog line
> from 2.4.9-ac13:

Check the workaround is being activated for your eepro100..
