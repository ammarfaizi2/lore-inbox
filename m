Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262139AbREPXdc>; Wed, 16 May 2001 19:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262141AbREPXdY>; Wed, 16 May 2001 19:33:24 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23821 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262139AbREPXc6>; Wed, 16 May 2001 19:32:58 -0400
Subject: Re: RH 7.1 on IBM xSeries 240
To: ps@rzeczpospolita.pl (ps)
Date: Thu, 17 May 2001 00:29:57 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B02504E.8F8926AB@rzeczpospolita.pl> from "ps" at May 16, 2001 12:02:54 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150Aju-0004cH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hm, page 0009f000 reserved twice.
> hm, page 000a0000 reserved twice.
> WARNING: MP table in the EBDA can be UNSAFE

These are ok...

> ENABLING IO-APIC IRQs
> ...changing IO-APIC physical APIC ID to 14 ... ok.
> BIOS bug, IO-APIC#1 ID is 15 in the MPC table!...
> ... fixing up to 15. (tell your hw vendor)

Your BIOS tables seemed wrong..

> mtrr: your CPUs had inconsistent fixed MTRR settings
> mtrr: probably your BIOS does not setup all CPUs

And your BIOS fails to set up the MTRR's properly. These are real BIOS 
mistakes. They are ones Linux however took corrective action on.
