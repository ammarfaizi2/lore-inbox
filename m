Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261966AbRESSfi>; Sat, 19 May 2001 14:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261956AbRESSf2>; Sat, 19 May 2001 14:35:28 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:25362 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261950AbRESSfR>; Sat, 19 May 2001 14:35:17 -0400
Date: Sat, 19 May 2001 11:34:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ben LaHaise <bcrl@redhat.com>, Alexander Viro <viro@math.psu.edu>,
        Andrew Morton <andrewm@uow.edu.au>, Andries.Brouwer@cwi.nl,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <E1519Xe-00005c-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0105191132420.14472-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 19 May 2001, Alan Cox wrote:
>
> > Now that I'm awake and refreshed, yeah, that's awful.  But
> > echo "hot-add,slot=5,device=/dev/sda" >/dev/md0/control *is* sane.  Heck,
> > the system can even send back result codes that way.
> 
> Only to an English speaker. I suspect Quebec City canadians would prefer a
> different command set.

I was waiting for the "anglo-saxon" argument.

I don't think it's a valid argument. You already have "/dev". You already
have english names for the numbers in ioctl's (and let's not be mentally
dishonest and say "numbers are cross-cultural", because NOBODY MUST EVER
USE THE RAW NUMBERS - you have to use the anglo-saxon #define'd names
because the numbers aren't even cross-platform on Linux, much less
portable to other systems).

So the "English is bad" argument is a complete non-argument.

		Linus

