Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbTICI73 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 04:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbTICI73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 04:59:29 -0400
Received: from gate.in-addr.de ([212.8.193.158]:39090 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261666AbTICI71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 04:59:27 -0400
Date: Wed, 3 Sep 2003 10:57:35 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>, Andre Tomt <andre@tomt.net>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, mingo@redhat.com
Subject: Re: md: bug in file md.c, line 1440 (2.4.22)
Message-ID: <20030903085735.GB5762@marowsky-bree.de>
References: <3F5017CA.4080700@tomt.net> <16213.14893.955734.797630@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16213.14893.955734.797630@gargle.gargle.HOWL>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-09-03T10:47:41,
   Neil Brown <neilb@cse.unsw.edu.au> said:

> I have not idea how it got the failed flag.

What's proven very helpful to figure out these things is to run a
test script against md, and just trying all the various possible actions
via mdadm or raidtools randomly.

I've done that for m-p, and while it's not pretty, it is _really_
helpful and has found all sorts of weird accounting bugs in the md code
(2.4 has many): ftp://ftp.suse.com/pub/people/lmb/md-mp/mp-test.sh - if
anyone feels like extending it to include raid5/raid1 etc, that would be
cool ;-)



Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering		ever tried. ever failed. no matter.
SuSE Labs				try again. fail again. fail better.
Research & Development, SuSE Linux AG		-- Samuel Beckett

