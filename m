Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314420AbSEMU5r>; Mon, 13 May 2002 16:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314422AbSEMU5q>; Mon, 13 May 2002 16:57:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45842 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314420AbSEMU5p>; Mon, 13 May 2002 16:57:45 -0400
Date: Mon, 13 May 2002 13:57:15 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Changelogs on kernel.org
In-Reply-To: <20020512204140.GB7593@conectiva.com.br>
Message-ID: <Pine.LNX.4.33.0205131355060.32241-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 12 May 2002, Arnaldo Carvalho de Melo wrote:

> Em Sun, May 12, 2002 at 09:31:03PM +0100, Dr. David Alan Gilbert escreveu:
> > Perhaps insisting that each check in message includes a single line (sub
> > 60 chars) description; could turn those into description : name and
> > remove dupes?
> 
> That'd be nice indeed, like %{summary} and %{description} in rpm spec files 8)

We already have that requirement for patches that are emailed to me: the 
Subject line becomes the first line of the changelog, and as a result 
those changelogs are already fairly readable.

The email-patches also tend to have better changelogs for the simple
reason that people think more when they submit patches to me than they
seem to do when they just want to check something in (ie very few people
would send an email saying "fix misc problems" as the body of the email,
yet it's easy to do when you do "bk citool").

		Linus

