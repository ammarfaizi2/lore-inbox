Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316595AbSFLChq>; Tue, 11 Jun 2002 22:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317309AbSFLChp>; Tue, 11 Jun 2002 22:37:45 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:32248 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S316595AbSFLChp>; Tue, 11 Jun 2002 22:37:45 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15622.46070.70066.758760@wombat.chubb.wattle.id.au>
Date: Wed, 12 Jun 2002 12:37:42 +1000
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org,
        <hermes@gibson.dropbear.id.au>, <alan@lxorguk.ukuu.org.uk>
Subject: Re: yenta_socket driver PCI irq routing fix
In-Reply-To: <Pine.LNX.4.44.0206111914210.32482-100000@home.transmeta.com>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Linus" == Linus Torvalds <torvalds@transmeta.com> writes:


Linus> (That said, I just cannot imagine how you could not hook up the
Linus> INTA/B lines correctly, and still have a working setup. So this
Linus> approach of just forcing the use of INTA and ignoring the old
Linus> ISA serial interrupt should be quite robust as far as I can
Linus> tell).

That's the approach used in the standalone pcmcia-cs package by David
Hinds --- I just copied the code...

--
Peter C					    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
