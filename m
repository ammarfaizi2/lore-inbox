Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287359AbSAGXPe>; Mon, 7 Jan 2002 18:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287355AbSAGXP0>; Mon, 7 Jan 2002 18:15:26 -0500
Received: from nile.gnat.com ([205.232.38.5]:53962 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S287359AbSAGXPQ>;
	Mon, 7 Jan 2002 18:15:16 -0500
From: dewar@gnat.com
To: jtv@xs4all.nl, tim.mcdaniel@tuxia.com, tim@hollebeek.com
Subject: RE: [PATCH] C undefined behavior fix
Cc: Dautrevaux@microprocess.com, dewar@gnat.com, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, paulus@samba.org,
        trini@kernel.crashing.org, velco@fadata.bg
Message-Id: <20020107231515.1D9A1F28F1@nile.gnat.com>
Date: Mon,  7 Jan 2002 18:15:15 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<In the above case it is unlikely that folding would present a problem,
but volatile was created because hardware, or even seemingly unrelated
software, can modify even the most unlikely memory locations.   If you
want to break device drivers, go ahead and optimize your compiler. =20
>>

No, I think that is the wrong domain of discourse here. We are not talking
about compilers being friendly, but rather correct. Most cetainly volatile
in Ada would not permit this optimzation (i.e. it would not be an optimization
it would be a miscompilation), and I certainly thought that in this respect
C was identical to Ada in semantics of volatile.
