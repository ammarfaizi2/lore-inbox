Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261848AbTCGXGi>; Fri, 7 Mar 2003 18:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261844AbTCGXGh>; Fri, 7 Mar 2003 18:06:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46349 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261848AbTCGXGg>; Fri, 7 Mar 2003 18:06:36 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Date: Fri, 7 Mar 2003 23:16:47 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b4b98v$14m$1@penguin.transmeta.com>
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030307123237.GG18420@atrey.karlin.mff.cuni.cz> <20030307165413.GA78966@dspnet.fr.eu.org> <20030307190848.GB21023@atrey.karlin.mff.cuni.cz>
X-Trace: palladium.transmeta.com 1047079021 15886 127.0.0.1 (7 Mar 2003 23:17:01 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 7 Mar 2003 23:17:01 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030307190848.GB21023@atrey.karlin.mff.cuni.cz>,
Pavel Machek  <pavel@suse.cz> wrote:
>
>So, basically, if branch was killed and recreated after each merge
>from mainline, problem would be solved, right?

Wrong.

Now think three trees.  Each merging back and forth between each other. 

Or, in the case of something like the Linux kernel tree, where you don't
have two or three trees.  You've got at least 20 actively developed
concurrent trees with branches at different points. 

Trust me. CVS simple CANNOT do this. You need the full information.

Give it up.  BitKeeper is simply superior to CVS/SVN, and will stay that
way indefinitely since most people don't seem to even understand _why_
it is superior. 

		Linus
