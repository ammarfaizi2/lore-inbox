Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263008AbVALHAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263008AbVALHAI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 02:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263012AbVALHAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 02:00:08 -0500
Received: from news.suse.de ([195.135.220.2]:16047 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263008AbVALG76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 01:59:58 -0500
Date: Wed, 12 Jan 2005 07:59:53 +0100
From: Andi Kleen <ak@suse.de>
To: torvalds@osdl.org, akpm@osdl.org, discuss@x86-64.org, vandrove@vc.cvut.cz,
       linux-kernel@vger.kernel.org
Subject: [0/4] Fixing x86-64 numa in 2.6.10rc1
Message-ID: <20050112065953.GA532@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hallo,

As some people already noticed 2.6.10rc1 unfortunately has broken
NUMA support on x86-64. The problem is a fallout from the recent
nodemask changes, which didn't really work well.

The following four patches fix the known problems.

Linus, please apply them. 

Anybody who uses a multi CPU Opteron system with 2.6.10rc1 should
apply them too or disable CONFIG_NUMA.

-Andi

