Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266569AbUITOFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266569AbUITOFb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 10:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266574AbUITOFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 10:05:31 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:49111 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266569AbUITOF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 10:05:27 -0400
Subject: Re: Design for setting video modes, ownership of sysfs attributes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Keith Packard <keithp@keithp.com>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <E1C98UF-0002Tn-DG@evo.keithp.com>
References: <E1C98UF-0002Tn-DG@evo.keithp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095685340.26652.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Sep 2004 14:02:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-09-19 at 21:40, Keith Packard wrote:
> I just need to know where the frame buffer lives; it can move or change 
> pitch at any time.  I can even deal with the frame buffer moving without 
> warning if necessary.  What I can't handle is off-screen memory suddenly 
> disappearing on me; I need to be able to pull any off-screen data back to 
> main memory before things get shuffled around.

The last one of these you can't get in the hotplug case but thats
currently a pretty unusual situation compared to the others

