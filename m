Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289116AbSAJBWw>; Wed, 9 Jan 2002 20:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289112AbSAJBWl>; Wed, 9 Jan 2002 20:22:41 -0500
Received: from nile.gnat.com ([205.232.38.5]:37011 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S289111AbSAJBWa>;
	Wed, 9 Jan 2002 20:22:30 -0500
From: dewar@gnat.com
To: jamagallon@able.es, pbarada@mail.wm.sps.mot.com
Subject: Re: [PATCH] C undefined behavior fix
Cc: Dautrevaux@microprocess.com, dewar@gnat.com, gcc@gcc.gnu.org,
        groudier@free.fr, jtv@xs4all.nl, linux-kernel@vger.kernel.org,
        paulus@samba.org, tim@hollebeek.com, trini@kernel.crashing.org,
        velco@fadata.bg
Message-Id: <20020110012229.C724EF2FEB@nile.gnat.com>
Date: Wed,  9 Jan 2002 20:22:29 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter said

<<Then the code can be optimized to 'b = 0;' since nowhere in the scope
of 'a' does anyone take its address(which would allow it to be changed).
Of course if 'a' is external then another function can access its
address.
>>

Well if nothing else this shows that there is still significant disagreement.
I consider Peter's statement to be 100% wrong here, optimizing away the
access to b would be a clear violation of the standard. I thought that
the argument had been made in a clear and convincing manner, but apparently
some people completely refuse to be convinced!
