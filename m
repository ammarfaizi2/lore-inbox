Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbTJEDSG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 23:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbTJEDSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 23:18:06 -0400
Received: from h1ab.lcom.net ([216.51.237.171]:1152 "EHLO digitasaru.net")
	by vger.kernel.org with ESMTP id S262960AbTJEDSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 23:18:03 -0400
Date: Sat, 4 Oct 2003 22:17:55 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: Scott West <swest3@cogeco.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cs4281 driver missing from 2.6.0-test6-bk6?
Message-ID: <20031005031754.GA8483@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: Scott West <swest3@cogeco.ca>,
	linux-kernel@vger.kernel.org
References: <20031005012438.GG4274@digitasaru.net> <20031004224102.64ff35c6.swest3@cogeco.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031004224102.64ff35c6.swest3@cogeco.ca>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Scott West on Saturday, 04 October, 2003:
>On Sat, 4 Oct 2003 20:24:39 -0500 Joseph Pingenot
><trelane@digitasaru.net> wrote:
>> Hello.
>> I was using menuconfig to check out 2.6.0-test6-bk6, when I found that
>>   the cs4281 ALSA driver had disappeared.
>> Is this intentional, did I screw something up, or is it accidental?
>> Thanks!
>> -Joseph
>Enabling joystick support under the input devices clears this up I believe. Sent me for a loop when I saw that too :).
>Scott

Aaaah.  Close.  It was "Gameport Support" that dunnit.  This laptop doesn't
  have such on it, so I thought I'd give it a whirl sans, especially since
  I'm trying to figure out why stuff is locking up on it.
Seems like an odd dependency.  You know why that is set up so?
Thankye.

-- 
Joseph===============================================trelane@digitasaru.net
"Asked by CollabNet CTO Brian Behlendorf whether Microsoft will enforce its
 patents against open source projects, Mundie replied, 'Yes, absolutely.'
 An audience member pointed out that many open source projects aren't
 funded and so can't afford legal representation to rival Microsoft's. 'Oh
 well,' said Mundie. 'Get your money, and let's go to court.' 
Microsoft's patents only defensive? http://swpat.ffii.org/players/microsoft
