Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287284AbSACN3F>; Thu, 3 Jan 2002 08:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287279AbSACN2y>; Thu, 3 Jan 2002 08:28:54 -0500
Received: from NILE.GNAT.COM ([205.232.38.5]:58086 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S287276AbSACN2n>;
	Thu, 3 Jan 2002 08:28:43 -0500
From: dewar@gnat.com
To: Dautrevaux@microprocess.com, paulus@samba.org
Subject: RE: [PATCH] C undefined behavior fix
Cc: Franz.Sirl-kernel@lauterbach.com, benh@kernel.crashing.org,
        gcc@gcc.gnu.org, jtv@xs4all.nl, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org, minyard@acm.org, rth@redhat.com,
        trini@kernel.crashing.org, velco@fadata.bg
Message-Id: <20020103132837.71EFBF3257@nile.gnat.com>
Date: Thu,  3 Jan 2002 08:28:37 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<No, in fact the kernel isn't written in ANSI C. :)
If nothing else, the fact that it uses a lot of gcc-specific
extensions rules that out.  And it assumes that you can freely cast
pointers to unsigned longs and back again.  I'm sure others can add to
this list.
>>

Most certainly this list should exist in precise defined form. It is not
unreasonable to have a specific list of features that

a) significant programs rely on, and are allowed to rely on
b) gcc promises to implement as specified, regardless of the standard

What is not reasonable is to have various people informally guess at things
that "obviously" can be expected to work in any "reasonable" C implementation.
It is this kind of informality that is asking for trouble.
