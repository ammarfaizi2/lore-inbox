Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBGXaU>; Wed, 7 Feb 2001 18:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129256AbRBGXaL>; Wed, 7 Feb 2001 18:30:11 -0500
Received: from jalon.able.es ([212.97.163.2]:676 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129032AbRBGX36>;
	Wed, 7 Feb 2001 18:29:58 -0500
Date: Thu, 8 Feb 2001 00:29:50 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        dledford@redhat.com
Subject: Re: [bug] aic7xxx panic Re: Linux 2.4.1-ac5
Message-ID: <20010208002950.A1254@werewolf.able.es>
In-Reply-To: <E14QbMw-0001JD-00@the-village.bc.nu> <Pine.LNX.4.21.0102072113080.1699-100000@penguin.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.21.0102072113080.1699-100000@penguin.homenet>; from tigran@veritas.com on Wed, Feb 07, 2001 at 23:13:29 +0100
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.07 Tigran Aivazian wrote:
> Alan, Doug,
> 
> If this is a known problem -- ignore. Otherwise, I will gladly assist as
> much as you need.
> 
> Just tried ac5 kernel and, behold (btw, why does serial console not work
> anymore, I had to copy these by hand):
> 
> (scsi0) BRKADRINT error(0x44):
>   Illegal Opcode in sequencer program
>   PCI Error detected
> (scsi0)  SEQADDR=0x58
> Kernel panic: aic7xxx: unrecoverable BRKADRINT
> 
> The Linux 2.4.2-pre1 works fine. Next thing I was thinking was to try ac4
> and also to try on a different machine which has a different revision of
> the same type of aic7xxx HBA.
> 

I am running ac5 on a  AHA-2940U2/W, no problem.

I patched the kernel with a patch from Doug Ledford posted in the list.

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac5 #1 SMP Wed Feb 7 22:15:19 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
