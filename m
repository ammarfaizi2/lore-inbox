Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbTIZNr6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 09:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTIZNr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 09:47:58 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:51206 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262201AbTIZNr5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 09:47:57 -0400
Message-ID: <3F74459A.7060903@aitel.hist.no>
Date: Fri, 26 Sep 2003 15:56:42 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Nicolas Mailhot <Nicolas.Mailhot@laposte.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Keyboard oddness.
References: <1064569422.21735.11.camel@ulysse.olympe.o2t>	 <20030926102403.GA8864@ucw.cz>	 <1064572898.21735.17.camel@ulysse.olympe.o2t> <1064581715.23200.9.camel@ulysse.olympe.o2t>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Mailhot wrote:
[...]
> I wrote about monster autorepeats not every single duplicated keypress.
> I fully agree it's stupid to expect detecting every single bogus repeat.
> 
> However saying the system has no way to guess monster
> autorepeats=problem is just plain wrong. There *are* thresholds after
> which one can be 99% sure there is a problem (autorepeat gone mad or cat
> sitting on the keyboard). No one is going to complain he has to release
> a key every hundred or so repeats to confirm there's a human on the
> other side of the keyboard.
> 
First, such detection is kind of useless.  If I get 200 W's before
the system detects, well I'll fix it long before detection kicks
in by tapping the stuck key.  That tends to unstick it.
Keys don't usually get stuck when nobody's there, they stick because
of a missed release, not a bogus press.

Second - yes, people are going to get impressively pissed off
if they have to release a key now and then.  Scrolling on a heavily
loaded machine - it stops from time to time anyway - but now we
have to release the key all the time?

And don't even think of having to release a key now and then in
a action game.  Games may use any key, so no restriction on
which keys may repeat is useable.

Gamers press keys for a long time, movement keys in quake, the
accelerator key in a car game, the fire key in space invaders.
Bogus unsticking of keys isn't acceptable - there will certainly
be a storm of patches for removing the misfeature.

Helge Hafting




