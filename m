Return-Path: <linux-kernel-owner+w=401wt.eu-S932859AbWLSU3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932859AbWLSU3p (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 15:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932891AbWLSU3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 15:29:45 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:46610 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932859AbWLSU3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 15:29:45 -0500
Date: Tue, 19 Dec 2006 21:27:56 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Bob Copeland <me@bobcopeland.com>
cc: Dave Jones <davej@redhat.com>, "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: my handy-dandy, "coding style" script
In-Reply-To: <b6c5339f0612190942l5a3ea48ft3315ab991ffd4f32@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0612192125460.20733@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0612191044170.7588@localhost.localdomain> 
 <20061219164146.GI25461@redhat.com> <b6c5339f0612190942l5a3ea48ft3315ab991ffd4f32@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> >  just for fun, i threw the following together to peruse the tree (or
>> > any subdirectory) and look for stuff that violates the CodingStyle
>> > guide.  clearly, it's far from complete and very ad hoc, but it's
>> > amusing.  extra searches happily accepted.
>> 
>> I had a bunch of similar greps that I've recently been half-assedly
>> putting together into a single script too.
>> See http://www.codemonkey.org.uk/projects/findbugs/
>
> I don't know if anyone cares about them anymore, since I think gcc
> grew some smarts in the area recently, but there are a lot of lines of
> code matching "static int.*= *0;" and equivalents in the driver tree.

I'd really like to see the C compiler being enhanced to detect
"stupid casts", i.e. those, which when removed, do not change (a) the outcome
(b) the compiler warnings/error output.


	-`J'
-- 
