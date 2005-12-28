Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbVL1GPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbVL1GPq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 01:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbVL1GPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 01:15:45 -0500
Received: from gate.crashing.org ([63.228.1.57]:45279 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932485AbVL1GPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 01:15:45 -0500
Subject: Re: Suspend to {mem,disk} broken in 2.6.15-rc6/rc7 on my T42
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Dave Airlie <airlied@linux.ie>, Jules Villard <jvillard@ens-lyon.fr>
In-Reply-To: <20051227125504.GA11838@blatterie>
References: <20051226194527.GA3036@blatterie>
	 <Pine.LNX.4.64.0512261545460.14098@g5.osdl.org>
	 <1135641618.4780.3.camel@localhost.localdomain>
	 <20051227012053.GB9771@blatterie>
	 <1135646828.4780.10.camel@localhost.localdomain>
	 <20051227125504.GA11838@blatterie>
Content-Type: text/plain
Date: Wed, 28 Dec 2005 17:16:00 +1100
Message-Id: <1135750560.4635.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please back out those 2 DRM patches of me for 2.6.15. It seems
that they cause more problems than they solve due to bugs in the X
server. I need to rethink the solution. I'll come up with new patches
after 2.6.15 along with matching X.org patches that will check each
other driver version to avoid mixing issues. In the meantime, users will
have to live with the current problem (typically some machines not
waking up from sleep too).

Ben.


