Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130406AbRAaL4c>; Wed, 31 Jan 2001 06:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131042AbRAaL4X>; Wed, 31 Jan 2001 06:56:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24580 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130406AbRAaL4O>;
	Wed, 31 Jan 2001 06:56:14 -0500
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Message-Id: <200101310947.f0V9lFQ05854@flint.arm.linux.org.uk>
Subject: Re: [PATCH] Acorn SCSI loading
To: torben@kernel.dk (Torben Mathiasen)
Date: Wed, 31 Jan 2001 09:47:15 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010130222952.G873@fry> from "Torben Mathiasen" at Jan 30, 2001 10:29:52 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Torben Mathiasen writes:
> Just noticed the SCSI drivers for the ACORN bus weren't 
> updated to the new initialization. AFAIK these drivers couldn't 
> have been functional without this patch.

Please don't apply these!

I've already got patches in the ARM tree, and the -ac tree to fix this.  The
problem is to do the necessary stuff to get them into Linus tree.  (They've
existed since the SCSI changes came about).
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |        Russell King       linux@arm.linux.org.uk      --- ---
  | | | |            http://www.arm.linux.org.uk/            /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
