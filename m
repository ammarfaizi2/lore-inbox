Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265901AbSLISMC>; Mon, 9 Dec 2002 13:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266100AbSLISMC>; Mon, 9 Dec 2002 13:12:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13839 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265901AbSLISMC>; Mon, 9 Dec 2002 13:12:02 -0500
Date: Mon, 9 Dec 2002 10:20:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: Daniel Jacobowitz <dan@debian.org>, george anzinger <george@mvista.com>,
       Jim Houston <jim.houston@ccur.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       "David S. Miller" <davem@redhat.com>, <ak@muc.de>, <davidm@hpl.hp.com>,
       <ralf@gnu.org>, <willy@debian.org>
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
In-Reply-To: <OFD8A28E03.33C21720-ONC1256C8A.00616515@de.ibm.com>
Message-ID: <Pine.LNX.4.44.0212091020180.10925-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Dec 2002, Martin Schwidefsky wrote:
>
> The current system call restart doesn't change the system call number. We just
> substract two from the psw address (aka eip) and go back to user space.

You're not looking at a recent 2.5.x tree with the nanosleep() restart
logic.

		Linus

