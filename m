Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130356AbQLSSZE>; Tue, 19 Dec 2000 13:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130348AbQLSSYy>; Tue, 19 Dec 2000 13:24:54 -0500
Received: from [195.63.194.11] ([195.63.194.11]:31500 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S130375AbQLSSYo>; Tue, 19 Dec 2000 13:24:44 -0500
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision-ventures.com
Organization: EVISION-VENTURES AG
To: Andries Brouwer <aeb@veritas.com>, Paul Gortmaker <p_gortmaker@yahoo.com>
Subject: Re: [PATCH] ident of whole-disk ext2 fs
Date: Tue, 19 Dec 2000 19:46:17 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel list <linux-kernel@vger.kernel.org>, tytso@mit.edu
In-Reply-To: <3A3F42FC.4E341732@yahoo.com> <20001219184542.A367@veritas.com>
In-Reply-To: <20001219184542.A367@veritas.com>
MIME-Version: 1.0
Message-Id: <00121919461703.02742@rosomak.prv>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Wto 19. Grudzie? 2000 18:45, Andries Brouwer napisa?:
> On Tue, Dec 19, 2000 at 06:14:04AM -0500, Paul Gortmaker wrote:
> > I always disliked the unknown partition table messages you get when you
> > mke2fs a whole disk and don't bother with a table at all, so I fixed it.
> > Output before/after shown below:
> >
> >  Partition check:
> >   hda: hda1 hda2
> > - hdd: unknown partition table
> > + hdd: whole disk EXT2-fs, revision 1.0, 1k blocks, status: clean.
>
> A nice boot message.
>
> But what if you just replace the "unknown partition table"

What about the more correct. 
hdd: no partition table

There is no presumed "unknown" partition table at all when we can't recognize 
it.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
