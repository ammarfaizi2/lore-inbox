Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316355AbSFEUpO>; Wed, 5 Jun 2002 16:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316422AbSFEUpL>; Wed, 5 Jun 2002 16:45:11 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39182 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316355AbSFEUpI>; Wed, 5 Jun 2002 16:45:08 -0400
Date: Wed, 5 Jun 2002 13:43:47 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 swsusp: stop abusing headers with non-inlined functions
In-Reply-To: <20020605122714.GA4376@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0206051330370.1471-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm.. Which version of the kernel is this against? It doesn't apply to 
clean 2.5.20 (which doesn't even have suspend.c), nor does it apply to my 
current BK head with your previous patches installed.

Or does your mailer corrupt whitespace or something?

The difference seems to be one empty line. I applied it by hand, but I
wanted to point out to you that you're apparently generating patches
against some bogus kernel versions, and in general I will _not_ bother 
with patches that don't apply cleanly.

		Linus

