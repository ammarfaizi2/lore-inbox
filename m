Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270986AbTGPTDw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 15:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271022AbTGPTDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 15:03:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:36258 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270986AbTGPTDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 15:03:50 -0400
Date: Wed, 16 Jul 2003 12:16:27 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: nuno.monteiro@ptnix.com, linux-kernel@vger.kernel.org
Subject: Re: woes with 2.6.0-test1 and xscreensaver/xlock
Message-Id: <20030716121627.0ac0d238.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0307161454180.32541@montezuma.mastecende.com>
References: <20030716172758.GA1792@hobbes.itsari.int>
	<Pine.LNX.4.53.0307161454180.32541@montezuma.mastecende.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jul 2003 14:58:43 -0400 (EDT) Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:

| On Wed, 16 Jul 2003, Nuno Monteiro wrote:
| 
| > Is anyone else having trouble with xscreensaver/xlock under 2.6.0-test1? 
| > Whenever I lock my session using either "lock screen" from the menu (it 
| > launches 'xscreensaver lock', afaik) or "xlock", I cant seem to ever get 
| > my session back -- I type in the correct password, but they both just 
| > hang there. The exact same setup works flawlessly in 2.4.21, and just for 
| > the sake of curiosity I also tested 2.5.75, 2.5.74, 2.5.73, 2.5.72, 
| > 2.5.71 and 2.5.70, they all exhibit the same behaviour as 2.6.0-test1. I 
| > dont really have time to go on testing kernels to find out exactly where 
| > it broke, so I'm hoping anyone else is experiencing these woes.
| 
| Someone reported this on bugzilla too, but i failed to reproduce it so it 
| appears that perhaps something else died like the keyboard. I tried it 
| last night on 2.6.0-test1 and i managed to login fine. It does appear that 
| something else is dying. It'd be good if you could collect the last few messages 
| from /var/log/XFree86.0.log and /var/log/messages and also perhaps 
| /var/log/dmesg. 

It happens to me all the time (so I stopped using xscreensaver).

Alan says that it's fixed in RH 9 IIRC, but no details about the
problem or the fix.... ?  Sounds a little like a userspace (library
or syscall) issue.  Someone mentioned PAM also.

--
~Randy
| http://developer.osdl.org/rddunlap/ | http://www.xenotime.net/linux/ |
For Linux-2.6:
http://www.codemonkey.org.uk/post-halloween-2.5.txt
  or http://lwn.net/Articles/39901/
http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
