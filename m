Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267430AbTALTgV>; Sun, 12 Jan 2003 14:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267431AbTALTeu>; Sun, 12 Jan 2003 14:34:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5893 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267430AbTALTee>; Sun, 12 Jan 2003 14:34:34 -0500
Date: Sun, 12 Jan 2003 11:38:35 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rob Wilkens <robw@optonline.net>
cc: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
In-Reply-To: <1042400094.1208.26.camel@RobsPC.RobertWilkens.com>
Message-ID: <Pine.LNX.4.44.0301121134340.14031-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 12 Jan 2003, Rob Wilkens wrote:
> 
> I'm REALLY opposed to the use of the word "goto" in any code where it's
> not needed.

I think goto's are fine, and they are often more readable than large
amounts of indentation. That's _especially_ true if the code flow isn't
actually naturally indented (in this case it is, so I don't think using
goto is in any way _clearer_ than not, but in general goto's can be quite
good for readability).

Of course, in stupid languages like Pascal, where labels cannot be 
descriptive, goto's can be bad. But that's not the fault of the goto, 
that's the braindamage of the language designer.

		Linus

