Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbUB2BUV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 20:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbUB2BUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 20:20:21 -0500
Received: from gate.crashing.org ([63.228.1.57]:48573 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261960AbUB2BUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 20:20:17 -0500
Subject: Re: [patch] new version, u64 cast avoidance
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: Jakub Jelinek <jakub@redhat.com>, "David S. Miller" <davem@redhat.com>,
       davidm@hpl.hp.com,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton OSDL <akpm@osdl.org>
In-Reply-To: <1078006870.2233.94.camel@cube>
References: <1077915522.2255.28.camel@cube>
	 <16447.56941.774257.925722@napali.hpl.hp.com>
	 <1077920213.2233.44.camel@cube>
	 <20040228104252.GG31589@devserv.devel.redhat.com>
	 <1077979564.2233.70.camel@cube>  <1078012722.905.11.camel@gaston>
	 <1078012762.905.13.camel@gaston>  <1078006870.2233.94.camel@cube>
Content-Type: text/plain
Message-Id: <1078016927.904.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 29 Feb 2004 12:08:47 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> a. my solution, as given
> b. move u64 and friends to include/linux/*.h
> c. you promise to never complain about warnings
> d. printk("Ugly: " U64_FMT "\n", some_u64_value);
> e. you patch gcc to modify format strings :-)
> f. ...
> 
> In other words, how do you propose to eliminate
> the casts?

Can't we live with those casts at least for a while ?

I don't know honestly what is the best solution, they all sound
equally ugly to me.

Ben.


