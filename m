Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263866AbSITWGE>; Fri, 20 Sep 2002 18:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263867AbSITWGE>; Fri, 20 Sep 2002 18:06:04 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:28627 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S263866AbSITWGD>;
	Fri, 20 Sep 2002 18:06:03 -0400
Date: Fri, 20 Sep 2002 15:11:09 -0700
To: Neil Booth <neil@daikokuya.co.uk>
Cc: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>, jt@hpl.hp.com,
       Jeff Garzik <jgarzik@mandrakesoft.com>, thunder@lightweight.ods.org,
       linux-kernel@vger.kernel.org
Subject: Re: FW: 2.5.34: IR __FUNCTION__ breakage
Message-ID: <20020920221109.GA9184@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20020920171901.GG8260@bougret.hpl.hp.com> <Pine.BSF.4.44.0209202006040.13460-100000@e0-0.zab2.int.zabbadoz.net> <20020920214138.GA9638@daikokuya.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020920214138.GA9638@daikokuya.co.uk>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 10:41:38PM +0100, Neil Booth wrote:
> Bjoern A. Zeeb wrote:-
> 
> > > > Also, specifically relating to varargs macros as described above, you
> > > > can certainly have a varargs macro with zero args, just look at C99
> > > > varargs macros...
> > >
> > > 	I remember that it didn't work. Ok, I'll try again.
> > 
> > if I remember corretly with C99 if you do s.th. like this (simple
> > sample):
> > 
> > #define LOG(level, format, ...)					\
> >                 log(level, format, ##__VA_ARGS__);
> 
> No, this is only valid C99 if __VA_ARGS__ is the empty list.
> 
> I posted the correct way to write this macro about a week ago that
> works with all versions of GCC (and follows their documented
> behaviour; this stuff *is* all documented).
> 
> Neil.

	Err... Can you point me to your post ?

	Jean
