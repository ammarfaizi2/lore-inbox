Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266173AbUIBWKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUIBWKo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269167AbUIBWHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:07:23 -0400
Received: from mx1.kth.se ([130.237.32.140]:44171 "EHLO mx1.kth.se")
	by vger.kernel.org with ESMTP id S269232AbUIBWDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:03:46 -0400
Date: Fri, 3 Sep 2004 00:03:42 +0200 (CEST)
From: Per von Zweigbergk <pvz@e.kth.se>
To: linux-kernel@vger.kernel.org
Subject: CONFIG_BSD_DISKLABEL not in 2.6.8.1?
Message-ID: <Pine.LNX.4.44.0409030003200.1068-100000@quetzalcoatlite.e.kth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just installed Linux 2.6.8.1 on this system in order to access some
FreeBSD 5.1 partitions (I'm in process of migrating this particular
machine) -- but it seems it can't read BSD disklabels -- so only my root
partition is accessible. (The rest are in slices.)

Older kernel versions had a CONFIG_BSD_DISKLABEL option, which was 
configurable via menuconfig etcetera, but 2.6.8.1 doesn't seem to have it 
in menuconfig.

Though it does exist in the code, I've seen a few #ifdefs here and there 
to that effect.

I wanted to try compiling it in manually, but what I tried to do, (edit 
the .config file) greeted me with a warning that I should not edit the 
file manually, since it is automatically generated.

So, what's up here? Is the code likely to work? And if so, why is it not 
accessible through the configuration tools? And is it safe just to edit 
.config to compile it in?

At worst I can just boot back into the older version of Linux I have and 
copy the partitions to files, and mount them with the loopback device, but 
that seems to be rather suboptimal, although I do have the disk space to 
be able to pull that off.

-- 
Per von Zweigbergk <pvz@e.kth.se>



