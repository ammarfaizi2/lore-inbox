Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284728AbRLZSiZ>; Wed, 26 Dec 2001 13:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284730AbRLZSiQ>; Wed, 26 Dec 2001 13:38:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38923 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284728AbRLZSiB>; Wed, 26 Dec 2001 13:38:01 -0500
Subject: Re: writing device drivers for commercial hardware
To: toxischerabflussreiniger@gmx.net
Date: Wed, 26 Dec 2001 18:48:30 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C2A1D7E.25900.13D1DF@localhost> from "toxischerabflussreiniger@gmx.net" at Dec 26, 2001 06:57:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16JJ6M-0002gQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> know ... there's a small book with my card reader but you won't find 
> a single line about technical stuff in it.
> It's a (pretty simple and cheap) card reader connected to serial port.

If its connected to a serial port it may well be enough to find the
baud rate it uses and dump the data. If not then wire 

	Cardreader--->Linux Box----->Windows PC

and copy the serial data in both directions through the Linux box and also
log it.
