Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269423AbTHORGP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 13:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269461AbTHORGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 13:06:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:40117 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269423AbTHORGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 13:06:00 -0400
Date: Fri, 15 Aug 2003 10:02:35 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3-mm2, and my no audio whine, updated
Message-Id: <20030815100235.3e21d215.rddunlap@osdl.org>
In-Reply-To: <200308141049.18442.gene.heskett@verizon.net>
References: <200308141049.18442.gene.heskett@verizon.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Aug 2003 10:49:18 -0400 Gene Heskett <gene.heskett@verizon.net> wrote:

| Greetings;
| 
| I guess we can forget about parts of my "no audio" whine.  It turns 
| out there are alsa options in the "make menuconfig" that somehow are 
| not in "make xconfig".  Hint...

Can you be more specific?  I looked and didn't see differences,
although I admit that I didn't try every possible combination.

| I turned on what I thought was the right stuff, and was greeted by the 
| drum solo when I started kde just now.  So at least kde can make 
| noises now.

>From other emails:

} Have you tried alsamixer?  I'm pretty sure everything's muted by default.

and

} Alsa boots up muted.  Use alsamixer(1) (it is a curses app) to set
} your prefered volumes.  Then as root run 'alsactl store' to store
} said volumes.  Each boot running 'alsactl restore' will reset them.

| However, xawtv and gnomeradio are still mute, gnomeradio complaining 
| about not being able to access /dev/radio, and xawtv silently exiting 
| after the launch timeout.  Do I need to relink those devices in /dev?  
| If so, what to, or to what as the case may be?


--
~Randy
