Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264699AbTBETOc>; Wed, 5 Feb 2003 14:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbTBETOc>; Wed, 5 Feb 2003 14:14:32 -0500
Received: from air-2.osdl.org ([65.172.181.6]:63976 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264699AbTBETOa>;
	Wed, 5 Feb 2003 14:14:30 -0500
Date: Wed, 5 Feb 2003 11:22:17 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: gcc 2.95 vs 3.21 performance
In-Reply-To: <b1rni4$3dr$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L2.0302051120310.8517-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Feb 2003, Linus Torvalds wrote:

| In article <3E4045D1.4010704@rogers.com>,
| Jeff Muizelaar  <muizelaar@rogers.com> wrote:
| >
| >There is also tcc (http://fabrice.bellard.free.fr/tcc/)
| >It claims to support gcc-like inline assembler, appears to be much
| >smaller and faster than gcc. Plus it is GPL so the liscense isn't a
| >problem either.
| >Though, I am not really sure of the quality of code generated or of how
| >mature it is.
|
| tcc is interesting.  The code generation is pretty simplistic (read:
| trivially horrible for most things), but it sure is fast and small.  And
| judging by the changelog, Fabrice is trying to compile the kernel with
| it.
|
| For a lot of problems, small-and-fast is good.  Hell, some of the things
| I'd personally find interesting don't have any code generation part at
| all (static analysis of annotated source-code - stanford checker on the
| cheap).
Yep, that's exactly why I'm interested...

| And development doesn't always need good code generation (right
| now some people use "gcc -O0" for that, because anything else hurts too
| much.  Now, the code from tcc will probably look more like "-O-1", but
| at least you can test out things _quickly_).

-- 
~Randy

