Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288717AbSAICOD>; Tue, 8 Jan 2002 21:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288718AbSAICNx>; Tue, 8 Jan 2002 21:13:53 -0500
Received: from nile.gnat.com ([205.232.38.5]:22769 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S288717AbSAICNn>;
	Tue, 8 Jan 2002 21:13:43 -0500
From: dewar@gnat.com
To: dewar@gnat.com, mrs@windriver.com, paulus@samba.org
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Message-Id: <20020109021343.26DD2F2FFB@nile.gnat.com>
Date: Tue,  8 Jan 2002 21:13:43 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<and we load each one into our app, and place c1, c2 and c3 immediately
next to each other, and then run foo1, then foo2, then foo3, and then
check the side effects, c1, c2 and c3, I would claim we _must_ get
write 1 c1, write 2 c2, write 3 c3, and at the end, c1, c2 c3 should
be 1,2,3.  I find it obvious.
>>

Yes, of course! No one disagrees. I am talking about *LOADS* not stores,
your example is 100% irrelevant to my point, since it does stores.

If you think I was talking about stores (look back in the thread, you
will see that is your misconception), then no WONDER you are puzzled
by what you *thought* I said :-)

<<In part, it is because gcc has adopted this model of independent
translation units, that makes it a hard requirement in the case above,
for the accesses to be byte based.  Because if it had not, gcc would
not be able to implement the intended required semantics of each of
the units.  The requirements of the standard forced this because of
the implementation choice.
>>

All this is true, but totally irrelevant to the point I was making, which
was about loads, not stores.

>>Welcome to the world of programming.

If you feel that I need a welcome to the world of programming (in which
I have lived for 38 years, producing several million lines of delivered
commercial code), then it is likely you are misunderstanding what I
am saying :-)

Robert
