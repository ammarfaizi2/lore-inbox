Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265129AbTLWNCa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 08:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265132AbTLWNCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 08:02:30 -0500
Received: from mail.aei.ca ([206.123.6.14]:60147 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S265129AbTLWNCZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 08:02:25 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: DevFS vs. udev
Date: Tue, 23 Dec 2003 08:02:19 -0500
User-Agent: KMail/1.5.93
References: <E1AYl4w-0007A5-R3@O.Q.NET> <1072181538.672.23.camel@nomade> <1072183068.1204.2.camel@ham>
In-Reply-To: <1072183068.1204.2.camel@ham>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200312230802.19901.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 23, 2003 07:37 am, Marcelo Bezerra wrote:
> On Tue, 2003-12-23 at 09:12, Xavier Bestel wrote:
>
> > Le mar 23/12/2003 à 12:51, Bradley W. Allen a écrit :
> >
> > > DevFS was written by an articulate person who solved a lot of
> > > problems.  udev sounds more like a thug who's smug about winning,
> > > not explaining himself, saying things like "oh, the other guy
> > > disappeared, so who cares, you have to use my code, too bad it sucks".
> >
> > [...]
> >
> > > I've spent two hours on this problem, and that's absurd; 
> >
> > 
> > Man, you've convinced me ! 
> > You've spent *two* hours on this problem ?  Woah, these K-H and Viro
> > guys must be dorks if they don't subscribe to your theories. Who are
> > they to think their opinion matters more than yours, who spent *two*
> > hours on this problem ?
> > 
> > Are you the new DevFS's maintainer ?
>
> In spite you trying to make him sound foolish, I still think he has some
> good points. DevFS works great and it never did something that was
> broken for me, so I see no point in replacing it. Maybe Greg K-H and Al
> Viro can step in an enlighten us once and for all.

They have.  There are technical reasons.  From a technical point of view devfs
is _broken_ and cannot be fixed without major efforts.  It has be discovered 
that things can be done in user space (udev 10 had to be slowed down - it
was too fast and the kernel was not keeping up...).  So devfs was made
obsolete.

Not listening or like the reasons does not change them.

Ed Tomlinson
