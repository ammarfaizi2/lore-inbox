Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbVLULMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbVLULMW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 06:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbVLULMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 06:12:22 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:10896 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S932363AbVLULMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 06:12:21 -0500
Date: Wed, 21 Dec 2005 12:12:20 +0100
From: Sander <sander@humilis.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: David Lang <dlang@digitalinsight.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051221111220.GA28577@favonius>
Reply-To: sander@humilis.net
References: <200512201428.jBKESAJ5004673@laptop11.inf.utfsm.cl> <Pine.LNX.4.62.0512200951080.11093@qynat.qvtvafvgr.pbz> <1135102197.2952.23.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135102197.2952.23.camel@laptopd505.fenrus.org>
X-Uptime: 11:44:44 up 33 days, 22:51, 28 users,  load average: 2.59, 2.07, 1.88
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote (ao):
> > how many other corner cases are there that these distros just choose
> > not to support, but need to be supported and tested for the vanilla
> > kernel?
> 
> as someone who was at that distro in the time.. none other than XFS
> and reiserfs4.

FWIW, I have a few servers and my workstation running Reiser4 and
CONFIG_4KSTACKS=y for several months now, and haven't encountered
problems yet. One server also runs Reiser4 on top op lvm2, and another
Reiser4 on top of sw raid1.

I know -mm + Reiser4 + 4kstacks is bleeding edge in more than one way,
but I like that for my workstations and the servers are
test/non-critical.

All systems do have real-life load though. I'd be happy to provide data
from these systems. Just mail me the commands.

-- 
Humilis IT Services and Solutions
http://www.humilis.net
