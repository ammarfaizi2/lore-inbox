Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130346AbQKRFDy>; Sat, 18 Nov 2000 00:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131094AbQKRFDp>; Sat, 18 Nov 2000 00:03:45 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:22028 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130346AbQKRFDb>;
	Sat, 18 Nov 2000 00:03:31 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andries.Brouwer@cwi.nl, aeb@veritas.com, emoenke@gwdg.de, eric@andante.org,
        kobras@tat.physik.uni-tuebingen.de, koenig@tat.physik.uni-tuebingen.de,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: isofs broken (2.2 and 2.4) 
In-Reply-To: Your message of "Fri, 17 Nov 2000 17:21:53 -0800."
             <Pine.LNX.4.10.10011171720410.5987-100000@penguin.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 18 Nov 2000 15:33:23 +1100
Message-ID: <20566.974522003@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2000 17:21:53 -0800 (PST), 
Linus Torvalds <torvalds@transmeta.com> wrote:
>There's a test11-pre7 there now, and I'd really ask people to check out
>the isofs changes because slight worry about those is what held me up from
>just calling it test11 outright.
>
>It's almost guaranteed to be better than what we had before, but anyway..
>
>		Linus

namei.c: In function `isofs_find_entry':
namei.c:130: warning: passing arg 2 of `get_joliet_filename' from incompatible pointer type
namei.c:130: warning: passing arg 3 of `get_joliet_filename' from incompatible pointer type


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
