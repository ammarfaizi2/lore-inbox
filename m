Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281058AbRKDRvu>; Sun, 4 Nov 2001 12:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281057AbRKDRvk>; Sun, 4 Nov 2001 12:51:40 -0500
Received: from pyxis.wanadoo.be ([195.74.212.24]:9091 "EHLO pyxis.wanadoo.be")
	by vger.kernel.org with ESMTP id <S281058AbRKDRv1>;
	Sun, 4 Nov 2001 12:51:27 -0500
Message-ID: <3BE580E4.F17AF70C@altern.org>
Date: Sun, 04 Nov 2001 18:54:44 +0100
From: SpaceWalker <spacewalker@altern.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i586)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <E15zF9H-0000NL-00@wagner> <20011104163354.C14001@unthought.net> <160QM5-1HAz5sC@fmrl00.sul.t-online.com> <20011104172742Z16629-26013+37@humbolt.nl.linux.org> <20011104184159.E14001@unthought.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Østergaard wrote:
> 
> On Sun, Nov 04, 2001 at 06:28:47PM +0100, Daniel Phillips wrote:
> > On November 4, 2001 05:45 pm, Tim Jansen wrote:
> > > > The dot-proc file is basically a binary encoding of Lisp (or XML), e.g. it
> > > > is a list of elements, wherein an element can itself be a list (or a
> > >
> > > Why would anybody want a binary encoding?
> >
> > Because they have a computer?
> 
> Yes - good reason  :)
> 
> The "fuzzy parsing" userland has to do today to get useful information
> out of many proc files today is not nice at all.  It eats CPU, it's
> error-prone, and all in all it's just "wrong".
> 
> However - having a human-readable /proc that you can use directly with
> cat, echo,  your scripts,  simple programs using read(), etc.   is absolutely
> a *very* cool feature that I don't want to let go.  It is just too damn
> practical.
> 
> But building a piece of software that needs to reliably read out status
> information from a system providing something more and more resembling a GUI in
> text-files is becoming unnecessarily time-consuming and error-prone.
> 
> >
> > > It needs special parsers and will be almost impossible to access from shell
> > > scripts.
> >
> > No, look, he's proposing to put the binary encoding in hidden .files.  The
> > good old /proc files will continue to appear and operate as they do now.
> >
> 
> Exactly.
> 
> --
> ................................................................
> :   jakob@unthought.net   : And I see the elder races,         :
> :.........................: putrid forms of man                :
> :   Jakob Østergaard      : See him rise and claim the earth,  :
> :        OZ9ABN           : his downfall is at hand.           :
> :.........................:............{Konkhra}...............:
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

A good reason could be that a simple ps -aux uses hundreds of system
calls to get the list of all the processes ...
-- 
SpaceWalker

spacewalker@altern.org
ICQ 36157579
