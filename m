Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266010AbSLSSnq>; Thu, 19 Dec 2002 13:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266020AbSLSSnq>; Thu, 19 Dec 2002 13:43:46 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:60319 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266010AbSLSSno>;
	Thu, 19 Dec 2002 13:43:44 -0500
Date: Thu, 19 Dec 2002 18:49:58 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Eli Carter <eli.carter@inet.com>
Cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, lm@bitmover.com, lm@work.bitmover.com,
       torvalds@transmeta.com, vonbrand@inf.utfsm.cl, akpm@digeo.com
Subject: Re: Dedicated kernel bug database
Message-ID: <20021219184958.GA6837@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Eli Carter <eli.carter@inet.com>, John Bradford <john@grabjohn.com>,
	linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	lm@bitmover.com, lm@work.bitmover.com, torvalds@transmeta.com,
	vonbrand@inf.utfsm.cl, akpm@digeo.com
References: <200212191335.gBJDZRDL000704@darkstar.example.net> <3E020660.9020507@inet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E020660.9020507@inet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2002 at 11:48:16AM -0600, Eli Carter wrote:
 > >Also, we could have a non-web interface, (telnet or gopher to the bug
 > >DB, or control it by E-Mail).
 > Can you interface with bugzilla's database backend maybe?  It seems like 
 > refactoring bugzilla might be better?

It's an annoyance to me that the current bugzilla we use can only
do 1 way email. Ie, I receive email when things change, but I can't
reply to that mail and have my comments auto-added.
Other bugzillas can do this, so I think either some switch needs
to be enabled, or theres some extension not present.
(I'm a complete bugzilla weenie, and no nothing about how its set up).

 > >It could warn the user if they attach an un-decoded oops that their
 > >bug report isn't as useful as it could be, and if they mention a
 > >distribution kernel version, that it's not a tree that the developers
 > >will necessarily be familiar with
 > Perhaps a more generalized hook into bugzilla for 'validating' a bug 
 > report, then code specific validators for kernel work?

Its a nice idea, but I think it's a lot of effort to get it right,
when a human can look at the dump, realise its not decoded, and
send a request back in hardly any time at all.
I also don't trust things like this where if something goes wrong,
we could lose the bug report. People are also more likely to ping-pong
,argue or "how do I..." with a human than they are with an automated robot.


		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
