Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265325AbTLNBQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 20:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265326AbTLNBQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 20:16:55 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:39941 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265325AbTLNBQy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 20:16:54 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Increasing HZ (patch for HZ > 1000)
Date: 14 Dec 2003 01:05:28 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <brgd0o$hr4$1@gatekeeper.tmr.com>
References: <20031212220853.GA314@elf.ucw.cz> <1071269849.4182.14.camel@idefix.homelinux.org>
X-Trace: gatekeeper.tmr.com 1071363928 18276 192.168.12.62 (14 Dec 2003 01:05:28 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1071269849.4182.14.camel@idefix.homelinux.org>,
Jean-Marc Valin  <Jean-Marc.Valin@USherbrooke.ca> wrote:
| 
| > Every notebook from thinkpad 560X up has produced some kind of
| > cpu-load-related-noise. You'd have to throw out quite a lot of
| > notebooks...
| 
| You're right, I'm probably not the only one. It may be worth at least
| having an option to change HZ to less annoying values. Otherwise there
| are going to be lots of complaints when people try out 2.6 on their
| laptops and hear that noise. On mine, I seriously could not stand the
| noise more than 5 minutes. Not because it was that loud but 1 kHz is
| really annoying.
| 
| > PS: Jean, can you try how high you can get it? You might want to go to
| > 24kHz so that no human can hear it, or to 100kHz to be kind to
| > cats. At ~1MHz you'd be even kind to bats :-), but it is probably
| > impossible to get over 200kHz or so. Still it might be funny
| > experiment.
| 
| For now, my patch only allows up to around 10 kHz. At that frequency, I
| don't hear anything because the noise is not loud enough (ear is much
| more sensitive at 1 kHz). Also, I have around 10% overhead on my
| Pentium-M 1.6 GHz, so I guess it's not for everyone. Extrapolating from
| there, I'd also say that at 100 kHz, it wouldn't do anything but handle
| the interrupts, which is slightly annoying when you want to actually get
| some work done :)
| 
| 	Jean-Marc

Stop! This is Linux we're talking about, if we can have Morse code panic
messages, we can certainly have the idle loop change frequency to play a
tune on the output capacitors (or whatever else make noise). How about
the Penguin army marching music from the Saturday morning cartoon, and
maybe hack LinuxBIOS to check for Windows running and have the idle loop
play Twilight of the Gods.

I better stop before someone actually does it.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
