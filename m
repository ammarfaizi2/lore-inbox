Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbTJ1AQl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 19:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbTJ1AQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 19:16:41 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:4612 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263784AbTJ1AQk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 19:16:40 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: sbp2 slab corruiton in 2.6-test9
Date: 28 Oct 2003 00:06:28 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bnkbu4$maf$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.44.0310261357100.16378-100000@parcelfarce.linux.theplanet.co.uk> <20031026141837.GA7904@phunnypharm.org>
X-Trace: gatekeeper.tmr.com 1067299588 22863 192.168.12.62 (28 Oct 2003 00:06:28 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031026141837.GA7904@phunnypharm.org>,
Ben Collins  <bcollins@debian.org> wrote:
| On Sun, Oct 26, 2003 at 02:01:26PM +0000, Matthew J Galgoci wrote:
| > Hi Folks,
| > 
| > I'm seeing slab corruption in 2.6-test9 when I do a 
| > cat /proc/scsi/scsi
| > 
| 
| Known. The fix is non-trivial, so I am holding off on it until 2.6.0
| gets out.

Is the fix available somewhere? I have a machine with external devices
which does just that cat as part of rc.local, to see what's connected. I
do understand your not wanting to make a major change now, but a fix
could get some mileage if it were out.

Is this a new bug since test6?
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
