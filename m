Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVC1Ce7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVC1Ce7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 21:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVC1Ce7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 21:34:59 -0500
Received: from gate.crashing.org ([63.228.1.57]:714 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261668AbVC1Ce5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 21:34:57 -0500
Subject: Re: Mac mini sound woes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050328014259.GF4110@g5.random>
References: <1111966920.5409.27.camel@gaston>
	 <20050328014259.GF4110@g5.random>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 12:34:30 +1000
Message-Id: <1111977271.5473.44.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-28 at 03:42 +0200, Andrea Arcangeli wrote:
> On Mon, Mar 28, 2005 at 09:42:00AM +1000, Benjamin Herrenschmidt wrote:
> > suggest I just don't do any control ? Or should I implement a double
> > buffer scheme with software gain as well in the kernel driver ?
> 
> I recall to have sometime clicked on volume controls that weren't
> hardware related, I don't pay much attention when stuff works, perhaps
> it was the kde sound system doing it or something like that.
> 
> I would suggest doing the D->A only, then adding a basic hack to
> g5 too ;), and then go back to the mini to do the gain emulation in
> kernel space if somebody complains ;). Doing the software emulation
> sounds quite orthogonal to the rest so it can be done later if needed.
> 
> Too loud sound is better than no sound.

Will do, of course. As for the G5, yes, I need to work on that too.

Ben.


