Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131315AbRAQVRY>; Wed, 17 Jan 2001 16:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132726AbRAQVRO>; Wed, 17 Jan 2001 16:17:14 -0500
Received: from femail2.rdc1.on.home.com ([24.2.9.89]:1188 "EHLO
	femail2.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S131315AbRAQVQ7>; Wed, 17 Jan 2001 16:16:59 -0500
Message-ID: <3A660BAF.3926D757@Home.net>
Date: Wed, 17 Jan 2001 16:16:32 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: [QUESTION]: Applying patches ontop of patches (2.4.1pre7 
 to2.4.1pre8)
In-Reply-To: <Pine.LNX.4.30.0101172130580.2313-100000@space.comunit.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to everyone who replied :)

Sven Koch wrote:

> On Wed, 17 Jan 2001, Shawn Starr wrote:
>
> > What is the best way to apply a patch on top of a patch already applied?
> >
> > For example, with original sources 2.4.0 i applied 2.4.1pre7 but now
> > that pre8 is out, how do i apply those new patches without having to
> > delete the whole linux dir and untar 2.4.0 again just to apply pre8?
>
> reverse the patch for 2.4.1pre7
>
> for example: cd /usr/src/linux ; zcat 2.4.1pre7.gz | patch -p1 -R
>
> after that apply pre8
>
> c'ya
> sven
>
> --
>
> The Internet treats censorship as a routing problem, and routes around it.
> (John Gilmore on http://www.cygnus.com/~gnu/)
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
