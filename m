Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265426AbSLISjM>; Mon, 9 Dec 2002 13:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265898AbSLISjM>; Mon, 9 Dec 2002 13:39:12 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:10453 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S265426AbSLISjL>;
	Mon, 9 Dec 2002 13:39:11 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15860.58615.767758.764196@napali.hpl.hp.com>
Date: Mon, 9 Dec 2002 10:46:15 -0800
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Mikael Starvik <mikael.starvik@axis.com>,
       "'Daniel Jacobowitz'" <dan@debian.org>,
       "'george anzinger'" <george@mvista.com>,
       "'Jim Houston'" <jim.houston@ccur.com>,
       "'Stephen Rothwell'" <sfr@canb.auug.org.au>,
       "'LKML'" <linux-kernel@vger.kernel.org>,
       "'anton@samba.org'" <anton@samba.org>,
       "'David S. Miller'" <davem@redhat.com>, "'ak@muc.de'" <ak@muc.de>,
       "'davidm@hpl.hp.com'" <davidm@hpl.hp.com>,
       "'schwidefsky@de.ibm.com'" <schwidefsky@de.ibm.com>,
       "'ralf@gnu.org'" <ralf@gnu.org>,
       "'willy@debian.org'" <willy@debian.org>
Subject: RE: [PATCH] compatibility syscall layer (lets try again)
In-Reply-To: <Pine.LNX.4.44.0212090906340.3410-100000@home.transmeta.com>
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE4E9@mailse01.axis.se>
	<Pine.LNX.4.44.0212090906340.3410-100000@home.transmeta.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 9 Dec 2002 09:35:59 -0800 (PST), Linus Torvalds <torvalds@transmeta.com> said:

  Linus> And apparently ia64 is again being a singularly awkward
  Linus> architecture.

I don't want to interfere with your ability to take potshots ;-), but
just to avoid confusion: passing syscall arguments in registers is NOT
an architectural requirement, it just makes good sense.

	--david
