Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129110AbRBGWLI>; Wed, 7 Feb 2001 17:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129250AbRBGWK6>; Wed, 7 Feb 2001 17:10:58 -0500
Received: from host217-32-158-240.hg.mdip.bt.net ([217.32.158.240]:27400 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129110AbRBGWKt>;
	Wed, 7 Feb 2001 17:10:49 -0500
Date: Wed, 7 Feb 2001 22:13:29 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, dledford@redhat.com
Subject: [bug] aic7xxx panic Re: Linux 2.4.1-ac5
In-Reply-To: <E14QbMw-0001JD-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0102072113080.1699-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan, Doug,

If this is a known problem -- ignore. Otherwise, I will gladly assist as
much as you need.

Just tried ac5 kernel and, behold (btw, why does serial console not work
anymore, I had to copy these by hand):

(scsi0) BRKADRINT error(0x44):
  Illegal Opcode in sequencer program
  PCI Error detected
(scsi0)  SEQADDR=0x58
Kernel panic: aic7xxx: unrecoverable BRKADRINT

The Linux 2.4.2-pre1 works fine. Next thing I was thinking was to try ac4
and also to try on a different machine which has a different revision of
the same type of aic7xxx HBA.

Any more ideas?

Regards,
Tigran


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
