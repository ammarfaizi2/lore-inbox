Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265433AbUBJBdu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 20:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265476AbUBJBdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 20:33:49 -0500
Received: from mail.tmr.com ([216.238.38.203]:59149 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S265433AbUBJBds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 20:33:48 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Does anyone still care about BSD ptys?
Date: 10 Feb 2004 01:33:09 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <c09ccl$qkl$1@gatekeeper.tmr.com>
References: <c07c67$vrs$1@terminus.zytor.com> <c07i5r$ctq$1@news.cistron.nl> <20040209100940.GF21151@parcelfarce.linux.theplanet.co.uk>
X-Trace: gatekeeper.tmr.com 1076376789 27285 192.168.12.62 (10 Feb 2004 01:33:09 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040209100940.GF21151@parcelfarce.linux.theplanet.co.uk>,
 <viro@parcelfarce.linux.theplanet.co.uk> wrote:
| On Mon, Feb 09, 2004 at 08:59:39AM +0000, Miquel van Smoorenburg wrote:
| > In article <c07c67$vrs$1@terminus.zytor.com>,
| > H. Peter Anvin <hpa@zytor.com> wrote:
| > >Does anyone still care about old-style BSD ptys, i.e. /dev/pty*?  I'm
| > >thinking of restructuring the pty system slightly to make it more
| > >dynamic and to make use of the new larger dev_t, and I'd like to get
| > >rid of the BSD ptys as part of the same patch.
| > 
| > bootlogd(8) which is used by Debian and Suse is started as the
| > first thing at boottime. It needs a pty, and tries to use /dev/pts
| > if it's there but falls back to BSD style pty's if /dev/pts isn't
| > mounted - which will be the case 99% of the time.
| 
| So what's the problem with calling mount(2)?

Other than making an optional part of the kernel required... Not
impossible but something to consider.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
