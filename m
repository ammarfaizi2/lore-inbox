Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136298AbRATB1q>; Fri, 19 Jan 2001 20:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136948AbRATB10>; Fri, 19 Jan 2001 20:27:26 -0500
Received: from femail1.rdc1.on.home.com ([24.2.9.88]:31426 "EHLO
	femail1.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S136298AbRATB1Q>; Fri, 19 Jan 2001 20:27:16 -0500
Message-ID: <3A68E929.3E27D64E@home.com>
Date: Fri, 19 Jan 2001 20:26:01 -0500
From: John Cavan <johncavan@home.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Coding Style
In-Reply-To: <3A68809B.E12EF3D9@purplecoder.com> <3A68D725.DA5409A9@linux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:
> > One other thing.  Allot of people neglect to brace a statement if
> > it has a single line body.  This is VERY bad, always brace your
> > statements....
> >
> >  if (x = 1)
> >    if (y = 2)
> >      if (z = 3)
> >        for (i = 1; i < 10; i++)
> >          if ....
> >            switch (foo)
> >              .....
> >
> > ...is really stupid.  DON'T DO IT!
> 
> No, it's really stupid to surround it with braces that aren't needed. The
> above is incredibly easy to read and incredibly easy to trace and debug.

"really stupid" is probably too harsh in both cases...

Anyways, he has a point here: clarity. When doing late night debugging,
your eyes are not going to be fooled as easily if the result of the
condition is braced. Whether you consider it important is a personal
taste, but it is also consistent with multi-line if statements, and when
rapidly scanning code consistency is very useful.

The rest of it, I generally agree with, except I like perl. :o) But,
just like working for a company, you follow the standards for the system
you're working on.

John

P.S. What's wrong with perl? Very useful language IMHO.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
