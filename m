Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131992AbQKVA7b>; Tue, 21 Nov 2000 19:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131993AbQKVA7V>; Tue, 21 Nov 2000 19:59:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10840 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131992AbQKVA7K>; Tue, 21 Nov 2000 19:59:10 -0500
Subject: Re: Linux 2.4.0test11-ac1
To: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 22 Nov 2000 00:29:09 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8vf2oo$338$1@cesium.transmeta.com> from "H. Peter Anvin" at Nov 21, 2000 04:07:52 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13yNmg-0005QD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Intel stuff appears to always be happy poking in APIC space. I don't know
> > if this is related to the chip internals on the non APIC capable chips.
> 
> Nononono... the 82489DX is an *external* APIC, which should be usable
> on any Socket 5/7 CPU...

I know of no socket 7 board with an 82489DX, and no board on the planet which
has 82489DX and works SMP with a non intel processor. I accept its a heuristic
but so is the current behaviour, and the current heuristic isnt working for
as many cases.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
