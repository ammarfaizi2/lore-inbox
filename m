Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318348AbSIPAlb>; Sun, 15 Sep 2002 20:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318356AbSIPAlb>; Sun, 15 Sep 2002 20:41:31 -0400
Received: from dsl-213-023-020-026.arcor-ip.net ([213.23.20.26]:40579 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318348AbSIPAla>;
	Sun, 15 Sep 2002 20:41:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Date: Mon, 16 Sep 2002 02:44:53 +0200
X-Mailer: KMail [version 1.3.2]
References: <E17qRfU-0001qz-00@starship> <20020915190435.GA19821@nevyn.them.org> <20020915162412.A17345@work.bitmover.com>
In-Reply-To: <20020915162412.A17345@work.bitmover.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17qk0T-0000E8-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 September 2002 01:24, Larry McVoy wrote:
> Does this mean I'm against debuggers?  Not at all.  But in 15 years of
> doing kernel work and 5 years of doing BK work the only thing I've ever
> used one for was to get a few variables printed out.  And I've written
> a substantial chunk of a debugger years ago, it's not a question of lack
> of debugger knowledge.  I just rarely find them useful.  

You are hereby invited to debug the DAC960 driver.  Making the needed
changes only took a few hours to get it to the point where it initializes,
now it oopses in the interrupt handler, because I did the bio part wrong.
Of course, you might not make any mistakes, but you probably will, so get
ready with your printks.  It's going to take you a while, I can assure
you.

I flat out refuse to do this without kgdb.

-- 
Daniel
