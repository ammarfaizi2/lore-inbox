Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLNRuI>; Thu, 14 Dec 2000 12:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129771AbQLNRt5>; Thu, 14 Dec 2000 12:49:57 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:45585
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S129345AbQLNRtp>; Thu, 14 Dec 2000 12:49:45 -0500
Date: Thu, 14 Dec 2000 12:28:28 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Leslie Donaldson <donaldlf@i-55.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Major Failure  2.4.0-test12 Alpha
Message-ID: <20001214122828.A30815@animx.eu.org>
In-Reply-To: <3A38E509.1030402@i-55.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <3A38E509.1030402@i-55.com>; from Leslie Donaldson on Thu, Dec 14, 2000 at 09:19:37AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
>   Just writing in to report a bug in 2.4.0-test12.
> Hardware:
>   PCI-Matrox_Mill
>   PCI-Adaptec 39160 / 160M scsi card
>   PCI-Generic TNT-2 card
>   PCI-Sound blaster -128 (es1370)
> 
> CPU 21164a - Alpha
> 
> Problem:
>   There is a race condition in the aic7xxxx driver that causes the 
> kernel to lock up.
> I don't have a kernel dump yet as the machine reported by it'self..
> This problem has been easy to reproduce. ergo about 3 crashes a day.
> 
> Solution:
>   Sync often and pray.
> 
> Misc:
>   As soon as I get a real dump I will post a followup to this message.

Just to add my 2 bits, I have an AlphaServer 1000A that has a pci-pci
bridge.  I put an adaptec 2940UW on the primary pci bus.  After attempts to
mke2fs on a raid0 set (using 2.2.17 /w and w/o raid patches), it would just
lock and I'd have to reboot the machine.  I was able (IIRC) to remount r/o
the other disk that I had.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
