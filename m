Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318305AbSIKFGw>; Wed, 11 Sep 2002 01:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318308AbSIKFGw>; Wed, 11 Sep 2002 01:06:52 -0400
Received: from waste.org ([209.173.204.2]:8340 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318305AbSIKFGv>;
	Wed, 11 Sep 2002 01:06:51 -0400
Date: Wed, 11 Sep 2002 00:11:36 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/11] Entropy fixes, take 3
Message-ID: <20020911051136.GO31597@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since the original set:

- applies to .34
- trust_pct sysctl compromise for headless machines
- corrected (less pessimistic) analysis of entropy distribution 
- more precise flood and polling defense - works on idle machines
- /dev/urandom readers won't starve /dev/random readers
- cleanup of reseeding logic and pool creation
- couple large stack vars made static
- remove a few hundred lines of legacy

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
