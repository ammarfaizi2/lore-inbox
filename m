Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbTIXGQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 02:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbTIXGQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 02:16:59 -0400
Received: from cube1.cubit.at ([80.78.231.68]:53941 "EHLO cube1.cubit.at")
	by vger.kernel.org with ESMTP id S261186AbTIXGQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 02:16:58 -0400
Date: Wed, 24 Sep 2003 08:16:57 +0200
From: Peter-Paul Witta <paul.witta@cubit.at>
To: linux-kernel@vger.kernel.org
Subject: strange memleak, alsa driver hickup?
Message-ID: <20030924061657.GA11738@cube1.cubit.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

please point me to a FAQ if this is solved...

I run 2.4.20 (still) and had a strange problem. as of a uptime of 72 days my
PC got strange. the memory was completely full (as shown by free, top,...)
even if no user procs ran. i restarted X but probably these leaks have to do
something with xine (Xv, Framebuffer?).

additional to this memleak there was a strange audio problem with my via82xx
ALSA driver: the more the mem leak grew the worse the sound output got. high
frequencies where cut out, low frequencies just were not sampled in a good way
-- it just got bad. 

after rebooting everything got ok. 

now, i have seen many memleaks, even in the kernel, but never did i see such
a sound problem? any hints?

kind regards,
paul.



