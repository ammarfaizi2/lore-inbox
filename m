Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264594AbTLQWr4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 17:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbTLQWr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 17:47:56 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:52749 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264594AbTLQWry
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 17:47:54 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: raid0 slower than devices it is assembled of?
Date: 17 Dec 2003 22:36:23 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <brqlp7$80v$1@gatekeeper.tmr.com>
References: <20031217192244.GB12121@mail.shareable.org> <Pine.LNX.4.58.0312171129040.8541@home.osdl.org>
X-Trace: gatekeeper.tmr.com 1071700583 8223 192.168.12.62 (17 Dec 2003 22:36:23 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.58.0312171129040.8541@home.osdl.org>,
Linus Torvalds  <torvalds@osdl.org> wrote:

| Let's say that you are striping four disks, with 32kB blocking. Not 
| an unreasonable setup.

Let me drop one of my pet complaints here, that the install programs of
many (most? all?) commercial releases don't give you a stripe size menu
to let the user make a decision based on intended use. Instead the
program uses the "one size fits all" approach and picks a size. As you
say here it's not unreasonable in terms of being typical, but for most
people it such for performance. As you noted elsewhere big stripes are
almost always better, and a default of 256k or so would work better for
most people.

Sorry, related flamage, but your comments welcome, since this does
affect the perception of performance of the o/s.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
