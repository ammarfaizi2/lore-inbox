Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265975AbRGHW3t>; Sun, 8 Jul 2001 18:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266031AbRGHW3i>; Sun, 8 Jul 2001 18:29:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:12928 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265975AbRGHW3X>;
	Sun, 8 Jul 2001 18:29:23 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15176.57025.611441.820947@pizda.ninka.net>
Date: Sun, 8 Jul 2001 15:29:21 -0700 (PDT)
To: Victor Yodaiken <yodaiken@fsmlabs.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Why Plan 9 C compilers don't have asm("")
In-Reply-To: <20010708155518.A23324@hq2>
In-Reply-To: <9i50uf$tla$1@penguin.transmeta.com>
	<20010708155518.A23324@hq2>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Victor Yodaiken writes:
 > This is something I don't get: I never understood why 32bit risc designers
 > were so damn obstinate about "every instruction fits in 32 bits"
 > and refused to have "call 32 bit immediate given in next word" not
 > to mention a "load 32bit immediate given in next word".

Sparc has such an instruction, in fact the instruction and the 32-bit
immediate fit in a single 32-bit instruction (since the immediate is
guarenteed to be modulo 4 you have some extra bits for the instruction
opcode itself).

Later,
David S. Miller
davem@redhat.com

