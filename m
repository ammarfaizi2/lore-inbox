Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265101AbTLCTMu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 14:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbTLCTMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 14:12:50 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:55562 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265101AbTLCTMt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 14:12:49 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: XFS for 2.4
Date: 3 Dec 2003 19:01:39 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bqlbuj$j03$1@gatekeeper.tmr.com>
References: <20031202002347.GD621@frodo> <Pine.LNX.4.44.0312020919410.13692-100000@logos.cnet>
X-Trace: gatekeeper.tmr.com 1070478099 19459 192.168.12.62 (3 Dec 2003 19:01:39 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0312020919410.13692-100000@logos.cnet>,
Marcelo Tosatti  <marcelo.tosatti@cyclades.com> wrote:

| A development tree is much different from a stable tree. You cant just
| simply backport generic VFS changes just because everybody agreed with
| them on the development tree.
| 
| My whole point is "2.6 is almost out of the door and its so much better".  
| Its much faster, much cleaner. 

Yes, a development tree is much different than a stable tree, and even
though the number has gone to 2.6, it's very much a development tree, in
that it's still being used by the same people, and probably not getting
a lot of new testing. Stability is unlikely to be production quality
until fixes go in for problems in mass testing, which won't happen until
it shows up in a vendor release, which won't happen until the vendors
test and clean up what they find... In other words, I don't expect it to
be "really stable" for six months at least, maybe a year.

As for "much faster," let's say that I don't see that on any apples to
apples benchmark. If you measure new threading against 2.4 threading
there is a significant gain, but for anything else the gains just don't
seem to warrant a "much" and there are some regressions shown in other
people's data.

I think 2.6 has new features, it is more scalable, but other than
threads I don't see any huge performance gains.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
