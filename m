Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131505AbRABVsL>; Tue, 2 Jan 2001 16:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131531AbRABVsB>; Tue, 2 Jan 2001 16:48:01 -0500
Received: from dialin189.pg6-nt.dusseldorf.nikoma.de ([213.54.101.189]:18670
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131505AbRABVrs>; Tue, 2 Jan 2001 16:47:48 -0500
Date: Tue, 2 Jan 2001 22:16:20 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: <dl8bcu@gmx.net>
cc: Gerold Jury <geroldj@grips.com>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        isdn mailing list <isdn4linux@listserv.isdn4linux.de>
Subject: Re: Happy new year^H^H^H^Hkernel..
In-Reply-To: <20010102190651.C26503@Marvin.DL8BCU.ampr.org>
Message-ID: <Pine.LNX.4.30.0101022211360.1202-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2001, Thorsten Kranzkowski wrote:

> On Tue, Jan 02, 2001 at 03:51:34AM +0100, Gerold Jury wrote:
> > The ISDN changes for the HISAX drivers
> > that came in since test12 have introduced a bug that causes a
> > AIEE-something and a complete kernel hang when i hangup the isdn line.
>
> I also saw this on my Alpha. Plus it hung one while the machine was idle
> and an analog phone call came in.
>
> For me disabling 'diversion services' solved the problem. Whether this fixed
> the problem or only hides it I don't know :)

I'm looking into this, but I'm not quite there yet. I don't believe it
really is connected to the INIT_LIST_HEAD changes, diversion services and
the Makefile changes are a more likely suspect. It'ld be nice if I could
reproduce it but I can't as of yet.

If somebody could catch a call trace, that would help a lot, too.

--Kai


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
