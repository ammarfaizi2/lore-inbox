Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130073AbRCAWhL>; Thu, 1 Mar 2001 17:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130072AbRCAWhD>; Thu, 1 Mar 2001 17:37:03 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28432 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130071AbRCAWgq>; Thu, 1 Mar 2001 17:36:46 -0500
Subject: Re: Linux 2.4.2ac7
To: tigran@veritas.com (Tigran Aivazian)
Date: Thu, 1 Mar 2001 22:39:46 +0000 (GMT)
Cc: jldomingo@crosswinds.net (José Luis Domingo López),
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.21.0103012106050.754-100000@penguin.homenet> from "Tigran Aivazian" at Mar 01, 2001 09:11:27 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Ybjg-0000IG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Linux 2.4.2-ac7 reports wrong CPU speed and model name for a Pentium II=
> I
> > correctly detected on, at least, 2.2.18, 2.4.2 and 2.4.2-ac4. The
> > processor is a 600 MHz one, with a 133 MHz front bus.

The model name printing has not changed. Not at all.

> same here with PIII550MHz/100MHz bus. Actually, it is wrong in 2.4.2-ac6
> as well -- don't know about ac5:

Please send me the value of your 0x2A MTRR. Because this isnt properly intel
documented there is a certain amount of research still required.

363 / 66 would be a 66Mhz bus 5.5 multiplier. It got the multiplier right
but it appears the bus speed encoding may be different.

