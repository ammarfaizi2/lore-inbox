Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbVL1VuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbVL1VuT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 16:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbVL1VuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 16:50:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33726 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964927AbVL1VuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 16:50:16 -0500
Date: Wed, 28 Dec 2005 13:49:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Dave Airlie <airlied@linux.ie>, Jules Villard <jvillard@ens-lyon.fr>
Subject: Re: Suspend to {mem,disk} broken in 2.6.15-rc6/rc7 on my T42
In-Reply-To: <1135750560.4635.3.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0512281348220.14098@g5.osdl.org>
References: <20051226194527.GA3036@blatterie>  <Pine.LNX.4.64.0512261545460.14098@g5.osdl.org>
  <1135641618.4780.3.camel@localhost.localdomain>  <20051227012053.GB9771@blatterie>
  <1135646828.4780.10.camel@localhost.localdomain>  <20051227125504.GA11838@blatterie>
 <1135750560.4635.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Dec 2005, Benjamin Herrenschmidt wrote:
>
> Linus, please back out those 2 DRM patches of me for 2.6.15. It seems
> that they cause more problems than they solve due to bugs in the X
> server. I need to rethink the solution.

Hmm.. How many other problem reports do we have? Jules reported that your 
patch to use the max() of the aperture size and memsize fixed the problem 
for him (and I merged it). Does it have other downsides?

		Linus
