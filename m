Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270969AbTGPRti (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270965AbTGPRsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:48:01 -0400
Received: from 82-43-130-207.cable.ubr03.mort.blueyonder.co.uk ([82.43.130.207]:49351
	"EHLO efix.biz") by vger.kernel.org with ESMTP id S271001AbTGPRr1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:47:27 -0400
Subject: Re: woes with 2.6.0-test1 and xscreensaver/xlock
From: Edward Tandi <ed@efix.biz>
To: Nuno Monteiro <nuno.monteiro@ptnix.com>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030716172758.GA1792@hobbes.itsari.int>
References: <20030716172758.GA1792@hobbes.itsari.int>
Content-Type: text/plain
Message-Id: <1058378574.16995.13.camel@wires.home.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 16 Jul 2003 19:02:54 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-16 at 18:27, Nuno Monteiro wrote:
> Hi there people,
> 
> 
> Is anyone else having trouble with xscreensaver/xlock under 2.6.0-test1? 
> Whenever I lock my session using either "lock screen" from the menu (it 
> launches 'xscreensaver lock', afaik) or "xlock", I cant seem to ever get 
> my session back -- I type in the correct password, but they both just 
> hang there. The exact same setup works flawlessly in 2.4.21, and just for 
> the sake of curiosity I also tested 2.5.75, 2.5.74, 2.5.73, 2.5.72, 
> 2.5.71 and 2.5.70, they all exhibit the same behaviour as 2.6.0-test1. I 
> dont really have time to go on testing kernels to find out exactly where 
> it broke, so I'm hoping anyone else is experiencing these woes.

Yes, I reported the same problem (and others) on the 31st may and the
5th June.

It's good to see someone has found the gnome-terminal problem. The only
other biggie-ish is the rmmod issue.

Ed-T.

> Additionally, syslog spews out the following:
> 
> Jul 16 17:40:24 hobbes xscreensaver(pam_unix)[1501]: authentication 
> failure; logname= uid=501 euid=501 tty=:0.0 ruser= rhost=  user=nuno
> 
> I upgraded to the latest pam and xscreensaver packages from mandrake 
> cooker, but still no dice, it hangs exactly the same. And oh, this is 
> glibc 2.3.2, if thats interesting, and gcc 3.3.
> 
> Interestingly enough, sometimes killing the xscreensaver process leads to 
> a complete hang, although no oops is visible. With nmi_watchdog=1 it 
> doesnt hang, but it seems the keyboard is dead after killing xscreensaver 
> -- i see an error on console, something like 'xscreensaver: no interrupt 
> data for mouse/keyb on /proc/interrupt' (i didnt copy it down, sorry). 
> The keyboard is still useable from the console, but not from X.
> 
> Let me know if you need more info.


