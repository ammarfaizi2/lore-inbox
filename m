Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbTKJV4M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 16:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbTKJV4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 16:56:12 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:14084 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263215AbTKJV4L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 16:56:11 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Date: 10 Nov 2003 21:45:38 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bop0u2$726$1@gatekeeper.tmr.com>
References: <20031106130030.GC1145@suse.de> <20031106134713.GA798@suse.de> <3FAA52A3.9030000@cyberone.com.au> <20031106135211.GB1194@suse.de>
X-Trace: gatekeeper.tmr.com 1068500738 7238 192.168.12.62 (10 Nov 2003 21:45:38 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031106135211.GB1194@suse.de>, Jens Axboe  <axboe@suse.de> wrote:

| > AFAIK, Prakash cannot reproduce this bad behaviour with mm1, only mm2 (is
| > this right, Prakash?). So its something there (don't forget Andrew merges
| > the latest bk with his releases too).
| 
| I'm not aware of anything in that area that could explain the change.

I think it's interesting that he saw it with oldconfig. That would
indicate that the way the config was interpreted changed rather than the
config itself. That don't mean that he didn't have an undetected oddness
in the original config which wasn't detected in mm1, but it seems
unlikely.

I looked at some of my old make logs, but I haven't yet built test9 for
a system which doesn't have SCSI.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
