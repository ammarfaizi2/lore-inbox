Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264644AbTIJFMg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 01:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264658AbTIJFMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 01:12:36 -0400
Received: from zeus.city.tvnet.hu ([195.38.100.182]:21893 "EHLO
	zeus.city.tvnet.hu") by vger.kernel.org with ESMTP id S264644AbTIJFMd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 01:12:33 -0400
Subject: Re: 2.6.0-test4-mm5 and Warcraft III - WineX
From: Sipos Ferenc <sferi@mail.tvnet.hu>
To: Tony Jones <tbjones@interaccess.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1063170068.21762.1.camel@thelight.sir-tez.org>
References: <1063169563.21739.1.camel@thelight.sir-tez.org>
	 <1063170068.21762.1.camel@thelight.sir-tez.org>
Content-Type: text/plain; charset=
Content-Transfer-Encoding: 8BIT
Message-Id: <1063170943.3607.3.camel@zeus.city.tvnet.hu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Wed, 10 Sep 2003 07:15:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm testing the above kernel with mplayer, playing a non interleaved avi
video generates a heavy load even on a xp2100+, and tried to play the
same video under 2.6.0-test5 with con's O20 patch. My experience is
similar to yours, nick's patch is far better on the moment in heavy load
situation. The O20 patch has a side effect, it's somehow slowing down
the machine, e. g. when I compile the kernel under it, it takes much
more time to finish that.

Paco


2003-09-10, sze keltezéssel 07:01-kor Tony Jones ezt írta:
> I am not subscribed to the mailing list.  Please cc me on any replies,
> thanks!
> 
> Tony Jones
> aka
> Sir-Tez 
> 
> 
> On Tue, 2003-09-09 at 23:52, Tony Jones wrote:
> > In my testing of recent kernels 2.6.0-test5 and 2.6.0-test4-mm4 (mm6
> > wouldn't cooperate with X for some reason and I didn't do much
> > investigation) I've experied an easily replicable and highly annoying
> > problem with Warcraft III and WineX 3.1 (prebuilt).
> > 
> > After playing 1 or 2 games, or leaving the game idle in the chat room,
> > the sound will eventually start to stutter and chop badly.  In the
> > presence of this incredibly bad sound, the mouse and game respond just
> > fine (kudos to the scheduler on that point).  Considering the game is
> > played in "real-time" and is full of audio cues I hate to imagine that
> > Con's scheduler will be the "official" scheduler of 2.6 without having
> > this issue addressed.
> > 
> > The kernels I use are tainted with nvidia's video drivers, 1.0.4496.  
> > 
> > Nick's scheduler in 2.6.0-test4-mm5 seems to be the only thing capable
> > of correcting this problem.  In general operation, mm5's scheduler
> > seems better at handling about everything I threw at it, with a rare
> > xmms skip once in a week of use.
> > 
> > I'm not a developer but I'd love some feedback and or questions to
> > help figure out why this happens with Con's scheduler patches in mm4
> > and test5 to help improve 2.6.0 altogether.
> > 
> > Other stats:  gcc 3.2.3, AMD Athlon XP 2100+, 512MB RAM, ATA 100
> > drive, GF4 Ti4200.   I'll also post CFLAGS upon request.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
