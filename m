Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261193AbRERRHi>; Fri, 18 May 2001 13:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261173AbRERRHV>; Fri, 18 May 2001 13:07:21 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:6148 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S261172AbRERRG5>;
	Fri, 18 May 2001 13:06:57 -0400
Date: Thu, 17 May 2001 10:20:30 +0000
From: Pavel Machek <pavel@suse.cz>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Alexander Viro <viro@math.psu.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010517102029.A44@toy.ucw.cz>
In-Reply-To: <20010515145830.Y5599@sventech.com> <Pine.LNX.4.21.0105151208540.2339-100000@penguin.transmeta.com> <20010515154325.Z5599@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010515154325.Z5599@sventech.com>; from johannes@erdfelt.com on Tue, May 15, 2001 at 03:43:26PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > But no, I don't actually like sockets all that much myself. They are hard
> > to use from scripts, and many more people are familiar with open/close and
> > read/write.
> 
> Agreed.
> 
> It would be nice to use open/close/read/write for control and bulk and
> sockets for interrupt and isochronous.

What makes interrupt so different? Last time I checked int pipes were very
similar to bulk pipes... Do you care about "packet boundaries"? You can
somehow emulate with read, too...
								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

