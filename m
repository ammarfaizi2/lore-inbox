Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbQKSHVA>; Sun, 19 Nov 2000 02:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129152AbQKSHUu>; Sun, 19 Nov 2000 02:20:50 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:9738 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129136AbQKSHUl>;
	Sun, 19 Nov 2000 02:20:41 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200011190650.eAJ6oMs06975@saturn.cs.uml.edu>
Subject: Re: sunhme.c patch for new PCI interface (UNTESTED)
To: adam@yggdrasil.com (Adam J. Richter)
Date: Sun, 19 Nov 2000 01:50:22 -0500 (EST)
Cc: davem@redhat.com, jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
        willy@meta-x.org, wtarreau@yahoo.fr
In-Reply-To: <200011172215.OAA06687@adam.yggdrasil.com> from "Adam J. Richter" at Nov 17, 2000 02:15:03 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter writes:

> 	Can I have a hot plug PCI bridge card that connects to
> a regular PCI backplane (perhaps as some kind of CardBus docking
> station card)?  If so, all PCI drivers should use __dev{init,exit}{,data}.

PCI is certainly hot-plug hardware, but not on common desktop PCs.
Since PCI is so popular and so often not hot-plug, users should
not be forced to have hot-plug PCI support when they only need
hot-plug SCSI, etc.

Obvious hack:  __pciinit, __pciexit, __pciinitdata...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
