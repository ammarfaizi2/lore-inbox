Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131247AbQKKQcj>; Sat, 11 Nov 2000 11:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131287AbQKKQcU>; Sat, 11 Nov 2000 11:32:20 -0500
Received: from mout1.freenet.de ([194.97.50.132]:16365 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S131247AbQKKQcG>;
	Sat, 11 Nov 2000 11:32:06 -0500
Date: Sat, 11 Nov 2000 18:35:36 +0000
From: Ingo Rohloff <lundril@gmx.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with NFS in 2.4test10
Message-ID: <20001111183536.A758@flashline.chipnet>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20001109215045.A591@flashline.chipnet> <3A0B2FAB.334D36BC@asiapacificm01.nt.com> <3A0B30F3.FA703FAD@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <3A0B30F3.FA703FAD@mandrakesoft.com>; from Jeff Garzik on Thu, Nov 09, 2000 at 06:19:15PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ingo, do you have a BP6?  Make sure you have the latest BIOS for your
> motherboard, there have been many BIOS updates for some dual-Celeron
> motherboards.

I have to admit that I'm not sure what kind of dual board I got
(i have to have a closer look).
The reason is that this board is orgiginally for dual Pentium IIs.
I got two Celerons (in S370 format), and use two modified
MSI S370-to-Slot1 adaptor (aehm I hope I got this right)
cards to make the Celerons multiprocessor enabled.

I still think it is an 2.4test10 kernel issue, because
my machine won't crash (as far as I can tell) if I use
2.2.17. 

(Am I correct that 2.4test10 is a lot more fine granular threaded
 in the kernel than 2.2.17 ? 
 If this is true I suspect that there is some kind of
 race/deadlock situtation in the NFS code...
)

so long
  Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
