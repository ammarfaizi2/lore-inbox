Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129963AbQJaU0n>; Tue, 31 Oct 2000 15:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129958AbQJaU0d>; Tue, 31 Oct 2000 15:26:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31600 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129963AbQJaU0U>; Tue, 31 Oct 2000 15:26:20 -0500
Subject: Re: 2.2.18Pre Lan Performance Rocks!
To: baettig@scs.ch (Reto Baettig)
Date: Tue, 31 Oct 2000 20:26:57 +0000 (GMT)
Cc: jmerkey@timpanogas.org (Jeff V. Merkey), linux-kernel@vger.kernel.org
In-Reply-To: <39FEE2C8.1CC82DF2@scs.ch> from "Reto Baettig" at Oct 31, 2000 07:18:32 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qhzo-0008DX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why not solve the problem at the source and completely redesign the
> network stack? Get rid of the old sk_buff & co! Rip the whole network
> layer out! Redesign it and give the user a possibility of Zero-Copy
> networking!

For one because you don't need to do that to get zero copy networking for
most real world cases. Tux already implements the neccessary infrastructure
for these.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
