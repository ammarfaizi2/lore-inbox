Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291447AbSBAANr>; Thu, 31 Jan 2002 19:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291450AbSBAANh>; Thu, 31 Jan 2002 19:13:37 -0500
Received: from www.transvirtual.com ([206.14.214.140]:54290 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S291447AbSBAANc>; Thu, 31 Jan 2002 19:13:32 -0500
Date: Thu, 31 Jan 2002 16:12:46 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        linux-m68k@lists.linux-m68k.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] amiga input api drivers
In-Reply-To: <3C59DCC4.EA3848E@linux-m68k.org>
Message-ID: <Pine.LNX.4.10.10201311612180.6830-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > +   scancode = scancode >> 1;       /* lowest bit is release bit */
> > > > +   down = scancode & 1;
> > >
> > > Shouldn't that be the other way 'round?
> > 
> > I don't know. Anyone?
> 
> He's correct, the up/down event is received in the lsb bit, the other 7
> bits are the keycode.

Okay that has been fixed now :-) Another patch is coming your way.


