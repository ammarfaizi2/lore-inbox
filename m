Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263449AbTDXC3E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 22:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263469AbTDXC3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 22:29:04 -0400
Received: from franka.aracnet.com ([216.99.193.44]:10937 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263449AbTDXC3C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 22:29:02 -0400
Date: Wed, 23 Apr 2003 19:40:54 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Werner Almesberger <wa@almesberger.net>,
       Jamie Lokier <jamie@shareable.org>
cc: Matthias Schniedermeyer <ms@citd.de>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>, pat@suwalski.net
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <25450000.1051152052@[10.10.2.4]>
In-Reply-To: <20030423231149.I3557@almesberger.net>
References: <21660000.1051114998@[10.10.2.4]>
 <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay>
 <20030423183413.C1425@almesberger.net> <1560860000.1051133781@flay>
 <20030423191427.D3557@almesberger.net> <1570840000.1051136330@flay>
 <20030424001134.GD26806@mail.jlokier.co.uk>
 <20030423214332.H3557@almesberger.net>
 <20030424011137.GA27195@mail.jlokier.co.uk>
 <20030423231149.I3557@almesberger.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> In fact, forget about "volume".  Just have a "silent" parameter that
>> defaults to 0,
> 
> Default to make useless or disturbing noise ...

You turn it off once, and your distro keeps it that way. Doesn't seem
that onerous to me. 

The key difference is that that poor user who's setting the thing up 
for the first time has more of a clue what's going on. Making Linux
less hostile to new users is a Good Thing (tm).

> So these defaults would be hard-coded values that take into account,
> among other factors:
> 
>  - the actual audio hardware (e.g. variations in the analog part)
>  - possibly the position of a "volume" knob somewhere
>  - the environment of the machine (ambient noise, acceptable
>    volume level)
> 
> And all that for what ? 

And all for the fact that when the user sets up the system, it just
works. With sensible defaults. Instead of being an elitist piece of
crap that only l33t g33ks can use.

Even for people that are capable of debugging it, it's just not a
productive use of time. I have better things to do with my life that debug
non-inuitive user interfaces, thanks.

> If you want to turn up the volume after
> booting, all you need is one whole line in your rc scripts. So
> far I haven't seen a single argument as to why this wouldn't be
> sufficient.

It's about making it easy to use. The expert users can configure the
damned thing any way they please anyway. For novices, it should do
something intuitive out of the box. The same principle should apply
to reams of crappy software out there right now.

--On Wednesday, April 23, 2003 22:29:05 -0400 Pat Suwalski
<pat@suwalski.net> wrote:

> I believe he is saying that ever since 1984 and the Mac Plus, it has been
> expected that sound works right away without adding any lines anywhere.
> 
> I have not seen a computer in the last year and a half that has not had
> either onboard sound or a card. It is very standard hardware these days.
> Therefore, your soundcard should work just like your keyboard does. You
> do not have to add any lines to any rc script to get the keyboard
> working, do you? Sound should not have to be any different, in an ideal
> world.

Indeed. Initial impression of people upgrading a kernel from 2.4 to 2.5/6
is that "sound doesn't work in 2.5/6". Not good.

M.

