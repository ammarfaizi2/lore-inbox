Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136170AbREGO6L>; Mon, 7 May 2001 10:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136168AbREGO6B>; Mon, 7 May 2001 10:58:01 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1033 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136165AbREGO5r>; Mon, 7 May 2001 10:57:47 -0400
Subject: Re: Crash
To: cpraveen@cs.iastate.edu (C.Praveen)
Date: Mon, 7 May 2001 16:01:03 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.HPX.4.31.0105070927560.4184-100000@beast.cs.iastate.edu> from "C.Praveen" at May 07, 2001 09:37:09 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14wmVW-0003af-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it possible to screw up the hardware entirely from software? I made

In an abstract theoretical sense yes. Accidentally almost impossible.

> know is if there is any way to screw the board from software in such a way
> that power off and power on does not bring it up ?.

The only people are ever likely to do is to corrupt the CMOS, which is easily
cleared.

> Its a dual pentium-3 machine. The power supply is gone also, the power
> supply from the crashed machine does not bring up another normal computer,
> also power supply from normal computer does not bring up crashed computer.

Sounds like a rather more physical layer problem - like a power spike and
PSU failure.

BTW: Always put a voltmeter on a power supply before you swap it like that
to test it. You need to check the voltages under load look sane otherwise you
may end up using a failed PSU to blow up other motherboards which is a
rather expensive debugging error ;)

Alan

