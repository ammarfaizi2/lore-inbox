Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTLCWKa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 17:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbTLCWK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 17:10:29 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:24331 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262123AbTLCWKW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 17:10:22 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.4.23 includes Andrea's VM?
Date: 3 Dec 2003 21:59:12 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bqlmbg$k0n$1@gatekeeper.tmr.com>
References: <9cfptf6vts7.fsf@rogue.ncsl.nist.gov> <20031203183719.GD24651@dualathlon.random>
X-Trace: gatekeeper.tmr.com 1070488752 20503 192.168.12.62 (3 Dec 2003 21:59:12 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031203183719.GD24651@dualathlon.random>,
Andrea Arcangeli  <andrea@suse.de> wrote:
| On Wed, Dec 03, 2003 at 09:51:36AM -0500, Ian Soboroff wrote:
| > 
| > I have a machine with 12GB of RAM, and I've been running a 2.4.22-era
| > kernel with Andrea's patches on it, otherwise it dies from lack of
| > lowmem.  
| > 
| > The latest -aa patch is for 2.4.23-pre6, but I see in the 2.4.23
| > Changelog that at least some bits of Andrea's VM were merged.  Should
| > I be able to run a vanilla 2.4.23 on this box?
| 
| It's probably going to work an order of magnitude better thanks
| especially to the lower_zone_reserve algorithm.
| 
| However I'd still recommend to use my tree, the last two critical bits
| you need from my tree are inode-highmem and related_bhs. Those two are
| still missing, and you probably need them with 12G.
| 
| I'm going to release a 2.4.23aa1 btw, that will be the last 2.4-aa.

I'd like to thank you for all the great VM work you've done, and all the
help you gave me off-list back when 1GB was still "a hell of a lot of
RAM" and responded to tuning bdflush.

Since 2.4 is now frozen it's probably the last -aa release ever needed,
in any case. Future releases, if any, are unlikely to change anything
which would keep the patches from working.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
