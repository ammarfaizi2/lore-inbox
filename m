Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271180AbRHYVbs>; Sat, 25 Aug 2001 17:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271186AbRHYVb2>; Sat, 25 Aug 2001 17:31:28 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6668 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271180AbRHYVbY>; Sat, 25 Aug 2001 17:31:24 -0400
Subject: Re: [resent PATCH] Re: very slow parallel read performance
To: pcg@goof.com ( Marc) (A.) (Lehmann ) (pcg( Marc)@goof(A.).(Lehmann
	)com)
Date: Sat, 25 Aug 2001 22:33:36 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        phillips@bonn-fries.net (Daniel Phillips),
        riel@conectiva.com.br (Rik van Riel),
        roger.larsson@skelleftea.mail.telia.com (Roger Larsson),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010825213536.D18523@cerebro.laendle> from "pcg( Marc)@goof(A.).(Lehmann )com" at Aug 25, 2001 09:35:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15al3g-0008Ev-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> exactly this is a point: my disk can do 5mb/s with almost random seeks,
> and linux indeed reads 5mb/s from it. but the userpsace process doing
> read() only ever sees 2mb/s because the kernel throes away all the nice
> pages.

Which means the VM in the relevant kernel is probably crap or your working
set exceeds ram.
