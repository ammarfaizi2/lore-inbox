Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286615AbSAFAxK>; Sat, 5 Jan 2002 19:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286605AbSAFAxB>; Sat, 5 Jan 2002 19:53:01 -0500
Received: from NILE.GNAT.COM ([205.232.38.5]:15781 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S286603AbSAFAwx>;
	Sat, 5 Jan 2002 19:52:53 -0500
From: dewar@gnat.com
To: jkl@miacid.net, jsm28@cam.ac.uk
Subject: Re: [PATCH] C undefined behavior fix
Cc: Dautrevaux@microprocess.com, Franz.Sirl-kernel@lauterbach.com,
        benh@kernel.crashing.org, dewar@gnat.com, fw@deneb.enyo.de,
        gcc@gcc.gnu.org, jtv@xs4all.nl, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org, minyard@acm.org, paulus@samba.org,
        rth@redhat.com, trini@kernel.crashing.org, velco@fadata.bg
Message-Id: <20020106005250.42E1DF28F0@nile.gnat.com>
Date: Sat,  5 Jan 2002 19:52:50 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<Or to put it another way: The Linux kernel developers NEED an
implementation defined way to build a pointer from an address.  If
arithmatic on byte pointers isn't it (which is perfectly understandable)
and casting a pointer from an integer isn't it, then can someone please
tell us (not just "that will work for now" or "that will probably work")
how do we do that?
>>

Now that's a very reasonable question. Note that it is not just
kernel developers who need this, anyone doing memory mapped I/O
needs similar capabilities. They are present explicitly in Ada
(with address clauses), but not in C, so you do indeed need to
decide how to provide this capability in a reasonable manner.
