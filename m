Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269136AbTBZXQv>; Wed, 26 Feb 2003 18:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269137AbTBZXQv>; Wed, 26 Feb 2003 18:16:51 -0500
Received: from almesberger.net ([63.105.73.239]:35589 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S269136AbTBZXQt>; Wed, 26 Feb 2003 18:16:49 -0500
Date: Wed, 26 Feb 2003 20:26:47 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, kuznet@ms2.inr.ac.ru,
       kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Is an alternative module interface needed/possible?
Message-ID: <20030226202647.H2092@almesberger.net>
References: <20030217221837.Q2092@almesberger.net> <20030218050349.44B092C04E@lists.samba.org> <20030218042042.R2092@almesberger.net> <Pine.LNX.4.44.0302181252570.1336-100000@serv> <20030218111215.T2092@almesberger.net> <20030218142257.A10210@almesberger.net> <Pine.LNX.4.44.0302191454520.1336-100000@serv> <20030219231710.Y2092@almesberger.net> <Pine.LNX.4.44.0302212202020.1336-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302212202020.1336-100000@serv>; from zippel@linux-m68k.org on Sun, Feb 23, 2003 at 05:02:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Anyway, this alone would be not reason enough to change the module 
> interface, but another module interface would give us more flexibility and 
> reduce the locking complexity.

Wait, wait ! :-) There's one step you've left out: what we actually
expect the module interface to do. We have:

 - what it currently does, or what it did in the past
 - what users think it does
 - what users want it to do
 - what we think the users should want
 - what we think is a comfortable compromise

With "users", I mean primarily the guy who invokes "rmmod", or such.

Anyway, I'm afraid I can't offer much wisdom from experience for this
part, for I'm not much of a module user myself. I'll have more to say
on service interfaces, though.

Sorry for slowing down, but I'm currently quite busy absorbing all
the cool stuff that's recently been happening with UML. (So, blame
Jeff ;-))

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
