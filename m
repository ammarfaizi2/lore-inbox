Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290771AbSBFT7S>; Wed, 6 Feb 2002 14:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290772AbSBFT66>; Wed, 6 Feb 2002 14:58:58 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:9479 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S290771AbSBFT64>; Wed, 6 Feb 2002 14:58:56 -0500
Message-ID: <3C618AFD.7148EEAA@linux-m68k.org>
Date: Wed, 06 Feb 2002 20:58:53 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <Pine.LNX.4.33.0202060931220.19836-100000@athlon.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linus Torvalds wrote:

> > > However, some of it pays off already. Basically, I'm aiming to be able to
> > > accept patches directly from email, with the comments in the email going
> > > into the revision control history.
> >
> > Um, what's so special about it, what a shell script couldn't do as well?
> 
> About this particular change-set? Nothing. In fact, most of it is
> generated from a shell script before it goes into the BK archive.

Sorry, I meant the part about accepting patches directly from email.
Pine supports piping a mail to a script, this script could try to apply
the patch and extract the text in front of the patch, but it could of
course also recognize a bk patch and feed it to bk.
The important thing is to avoid two classes of patches, bk patches and
patches, which would create extra work for you. It would be no problem
to use tags, which can be easily extracted by above script, just tell
us, how they should look like.

bye, Roman
