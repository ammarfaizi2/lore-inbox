Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129063AbQJaU63>; Tue, 31 Oct 2000 15:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129097AbQJaU6T>; Tue, 31 Oct 2000 15:58:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14706 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129063AbQJaU6C>; Tue, 31 Oct 2000 15:58:02 -0500
Subject: Re: 2.2.18Pre Lan Performance Rocks!
To: pollard@tomcat.admin.navo.hpc.mil (Jesse Pollard)
Date: Tue, 31 Oct 2000 20:58:07 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, baettig@scs.ch (Reto Baettig),
        jmerkey@timpanogas.org (Jeff V. Merkey), linux-kernel@vger.kernel.org
In-Reply-To: <200010312048.OAA244641@tomcat.admin.navo.hpc.mil> from "Jesse Pollard" at Oct 31, 2000 02:48:53 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qiTx-0008Fu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also pay attention to the security aspects of a true "zero copy" TCP stack.
> It means that SOMETIMES a user buffer will recieve data that is destined
> for a different process.

The moment you try and do zero copy like that you end up playing so many MMU
games the copy is faster. We do zero copy from the kernel side of the universe
thats a lot lot saner

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
