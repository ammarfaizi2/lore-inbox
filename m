Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130196AbQK3L1G>; Thu, 30 Nov 2000 06:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130281AbQK3L0z>; Thu, 30 Nov 2000 06:26:55 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:45813 "EHLO
        delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
        id <S129756AbQK3L0o>; Thu, 30 Nov 2000 06:26:44 -0500
Date: Thu, 30 Nov 2000 11:48:56 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Mr. Big" <mrbig@sneaker.sch.bme.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: crashing kernels
In-Reply-To: <Pine.GSO.3.96.1001129121317.13815A-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.3.96.1001130114606.26714A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Maciej W. Rozycki wrote:

>  You appear to have the PIIX4 ISA bridge -- it contains an embedded ACPI
> controller.  It has it's IRQ hardwired to 11.  Try to move device IRQs
> away from it (by setting IRQ 11 to "ISA/Legacy" in BIOS).  While I've not
> heard of ACPI IRQ problems so far, it does not mean they never happen.

 This is of course incorrect -- the ACPI controller of PIIX4 uses IRQ 9. 
I have no idea why I thought it uses IRQ 11, yesterday... :-(

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
