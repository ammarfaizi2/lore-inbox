Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbTJUUg7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263337AbTJUUg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:36:58 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:14084 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263335AbTJUUg5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:36:57 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Blockbusting news, this is important (Re: Why are bad disk sectors numbered strangely, and what happens to them?)
Date: 21 Oct 2003 20:26:56 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bn44qg$ima$1@gatekeeper.tmr.com>
References: <20031018074223.GN1659@openzaurus.ucw.cz> <200310180830.h9I8ULuc000419@81-2-122-30.bradfords.org.uk>
X-Trace: gatekeeper.tmr.com 1066768016 19146 192.168.12.62 (21 Oct 2003 20:26:56 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200310180830.h9I8ULuc000419@81-2-122-30.bradfords.org.uk>,
John Bradford  <john@grabjohn.com> wrote:
| > > BTW: Hard drives apparently use more sophisticated algorithms,
| > > involving measuring head signal level even when there is no problem
| > > reading the data, and eventually remapping a sector on read before the
| > > information is lost.
| > > 
| > 
| > Which means cat /dev/hda > /dev/null makes sense in
| > cron.weekly...
| 
| Indeed.  Some drives can also do a timed defect scan using S.M.A.R.T.

You make the point I was going to question, is the cat (dd?) better than
a S.M.A.R.T. scan? I would think that the scan would be more likely to
be doing some special error checking, like turning off one level of ECC
or similar, and might see things a normal read might not. In other
words, the difference between no uncorrectable errors and no errors.

I am thinking of something like a C2 scan on a CD, to get error
detection without error correction.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
