Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUIMAwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUIMAwu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 20:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUIMAwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 20:52:50 -0400
Received: from host-63-144-52-41.concordhotels.com ([63.144.52.41]:55419 "EHLO
	080relay.CIS.CIS.com") by vger.kernel.org with ESMTP
	id S264668AbUIMAwl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 20:52:41 -0400
Subject: Re: radeon-pre-2
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Vladimir Dergachev <volodya@mindspring.com>
Cc: Dave Airlie <airlied@linux.ie>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0409122042370.9611@node2.an-vo.com>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <Pine.LNX.4.58.0409100209100.32064@skynet>
	 <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <20040910153135.4310c13a.felix@trabant>
	 <9e47339104091008115b821912@mail.gmail.com>
	 <1094829278.17801.18.camel@localhost.localdomain>
	 <9e4733910409100937126dc0e7@mail.gmail.com>
	 <1094832031.17883.1.camel@localhost.localdomain>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <1094853588.18235.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409110137590.26651@skynet>
	 <1094912726.21157.52.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409122319550.20080@skynet>
	 <1095035276.22112.31.camel@admin.tel.thor.asgaard.local>
	 <Pine.LNX.4.61.0409122042370.9611@node2.an-vo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Sun, 12 Sep 2004 20:52:23 -0400
Message-Id: <1095036743.22137.48.camel@admin.tel.thor.asgaard.local>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-12 at 20:45 -0400, Vladimir Dergachev wrote:
> 
> On Sun, 12 Sep 2004, Michel [ISO-8859-1] Dnzer wrote:
> 
> > On Sun, 2004-09-12 at 23:42 +0100, Dave Airlie wrote:
> >>
> >> I think yourself and Linus's ideas for a locking scheme look good, I also
> >> know they won't please Jon too much as he can see where the potential
> >> ineffecienes with saving/restore card state on driver swap are, especailly
> >> on running fbcon and X on a dual-head card with different users.
> >
> > Frankly, I don't understand the fuss about that. When you run a 3D
> > client on X today, 3D client and X server share the accelerator with
> > this scheme, and as imperfect as it is, it seems to do a pretty good job
> > in my experience.
> 
> Not that good - try dragging something while a DVD video is playing.

What are you getting at?


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer
