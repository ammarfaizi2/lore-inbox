Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279472AbRKXT5B>; Sat, 24 Nov 2001 14:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279547AbRKXT4w>; Sat, 24 Nov 2001 14:56:52 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:16909 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S279472AbRKXT4j>; Sat, 24 Nov 2001 14:56:39 -0500
Date: Sat, 24 Nov 2001 16:39:15 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Linux 2.4.16-pre1
Message-ID: <Pine.LNX.4.21.0111241636200.12066-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

So here it goes 2.4.16-pre1. Obviously the most important fix is the
iput() one, which probably fixes the filesystem corruption problem people
have been seeing.

Please, people who have been experiencing the fs corruption problems test
this and tell me its now working so I can release a final 2.4.16 ASAP.


- Correctly sync inodes in iput()			(Alexander Viro)
- Make pagecache readahead size tunable via /proc	(was in -ac tree)
- Fix PPC kernel compilation problems			(Paul Mackerras)

