Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262742AbUJ1DqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbUJ1DqS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 23:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbUJ1DqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 23:46:18 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:16539 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S262742AbUJ1DqO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 23:46:14 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Intel also needs convincing on firmware licensing.
Date: Wed, 27 Oct 2004 23:46:12 -0400
User-Agent: KMail/1.7
Cc: Han Boetes <han@mijncomputer.nl>
References: <20041028022532.GX26130@boetes.org>
In-Reply-To: <20041028022532.GX26130@boetes.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410272346.12283.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [141.153.91.102] at Wed, 27 Oct 2004 22:46:13 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 October 2004 22:25, Han Boetes wrote:
>Hi,
>
>The people from the OpenBSD project are currently lobbying to get
> the firmware for Intel wireless chipsets under a license suitable
> for Open Source.
>
>Since this will not only benefit BSD but also the Linux Project (and
>even Intel) I would like to mention the URL here for people who want
> to help writing to Intel.
>
>  http://undeadly.org/cgi?action=article&sid=20041027193425
>
Please be aware that for the so-called "software radios" 
chips/chipsets, the FCC, and other similar regulating bodies in other 
countries has made access to the data quite restrictive in an attempt 
to keep the less ruly among us from putting them on frequencies they 
aren't authorized to use, or to set the power levels above whats 
allowed.  These restrictions can vary from governing body to 
governing body so the software is generally supplied according to 
where the chipset is being shipped.  The potential for mischief, and 
legal/monetary reprecussions is sufficiently great that I have 
serious doubts that Intel will budge from their current position 
unless we can prove, beyond any doubt, that the regulatory 
limitations imposed will not be violated.

Since open source, where anyone who can read the code can see exactly 
what the limits are, and 'adjust to suit', virtually guarantees 
miss-use, sooner if not later, for no other reason than its human 
nature to experiment, Intel/moto/etc therefore has very good reasons 
to treat its chip<->software interface as highly secret & 
proprietary.

Thats not saying that they may at some point furnish a 'filter' that 
presents the rest of the world with a usable API to control it, but 
the filter will see to it that attempted illegal settings are 
ignored.  The only way I can see that actually working is to actually 
put that filter inside the chip, customized for the locale its being 
shipped to.  The radio control portion of the chip itself wouldn't 
even be bonded out to external world pins or bga contacts, just the 
port of the filter that the outside world talks to.

I'd rather doubt they want to make 20 to 40 different filtered 
versions of the same chipset just to satisfy TPTB in some 3rd world 
country thats less than 1% of the total sales.  Even the relatively 
dense market where Han lives is probably less than 5% of the total 
for a popular chipset. 

I'm a broadcast engineer who has been dealing at times with the FCC 
for over 40 years, so you could say I'm biased.  But thats not real 
bias, its just from being fairly familiar with the regulatory 
territory.

I'd like to see an open source solution to this problem myself, but 
just because its open source we are asking for, with the attendent 
liabilities that implies, I would not hold my breath till it happens. 

If you do, you'll probably be talking to the rest of the world through 
a Ouija board.

># Han

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
