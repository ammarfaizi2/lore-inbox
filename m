Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281050AbRKLW0x>; Mon, 12 Nov 2001 17:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281066AbRKLW0o>; Mon, 12 Nov 2001 17:26:44 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:3479 "HELO postfix2-1.free.fr")
	by vger.kernel.org with SMTP id <S281050AbRKLW0e> convert rfc822-to-8bit;
	Mon, 12 Nov 2001 17:26:34 -0500
Date: Mon, 12 Nov 2001 20:41:24 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Lionel Bouton <Lionel.Bouton@free.fr>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: File System Performance
In-Reply-To: <3BF04926.2080009@free.fr>
Message-ID: <20011112203504.F1809-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Nov 2001, Lionel Bouton wrote:

> Linus Torvalds wrote:
>
> >In article <3BF04289.8FC8B7B7@zip.com.au>,
> >Andrew Morton  <akpm@zip.com.au> wrote:
> >
> >>It's tar.  It cheats.  It somehow detects that the
> >>output is /dev/null, and so it doesn't read the input files.
> >>
> >
> >Probably the kernel.
> >
> Seems not the case with gnu tar : write isn't even called once on the fd
> returned by open("/dev/null",...). In fact a "grep write" on the strace
> output is empty in the "tar cf /dev/null" case. Every file in the tar-ed
> tree is stat-ed but no-one is read-ed.

This kind of guessing from gnu tar seems utterly stupid to me. Developpers
that spend time for such kind of fake optimization either have time to
waste or brain to be fixed. Just my opinion.

  Gérard.

