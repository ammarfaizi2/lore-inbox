Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266233AbSLIUTP>; Mon, 9 Dec 2002 15:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266243AbSLIUTP>; Mon, 9 Dec 2002 15:19:15 -0500
Received: from pizda.ninka.net ([216.101.162.242]:38544 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266233AbSLIUTO>;
	Mon, 9 Dec 2002 15:19:14 -0500
Date: Mon, 09 Dec 2002 12:22:17 -0800 (PST)
Message-Id: <20021209.122217.56508636.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: torvalds@transmeta.com, dan@debian.org, george@mvista.com,
       jim.houston@ccur.com, sfr@canb.auug.org.au,
       linux-kernel@vger.kernel.org, anton@samba.org, ak@muc.de,
       schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15860.53866.127553.424553@napali.hpl.hp.com>
References: <20021209154142.GA22901@nevyn.them.org>
	<Pine.LNX.4.44.0212090828460.3397-100000@home.transmeta.com>
	<15860.53866.127553.424553@napali.hpl.hp.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Mon, 9 Dec 2002 09:27:06 -0800

   >>>>> On Mon, 9 Dec 2002 08:48:13 -0800 (PST), Linus Torvalds <torvalds@transmeta.com> said:
   
     Linus> Architecture maintainers, can you comment on how easy/hard it
     Linus> is to do the same thing on your architectures? I _assume_
     Linus> it's trivial (akin to the three-liner register state change
     Linus> in i386/kernel/signal.c).
   
   It's not trivial on ia64:

It was really easy on Sparc.
