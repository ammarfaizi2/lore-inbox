Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVFEOvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVFEOvi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 10:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbVFEOvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 10:51:38 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:48372 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP id S261579AbVFEOvg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 10:51:36 -0400
Date: Sun, 5 Jun 2005 07:51:29 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, plist fixes
In-Reply-To: <20050605082616.GA26824@elte.hu>
Message-ID: <Pine.LNX.4.10.10506050749310.10127-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Jun 2005, Ingo Molnar wrote:
> 
> in any case, i've added most of your fixes and cleanups (changed the
> O(N) to O(K) and explained K) and have released the -47-17 patch.
> Daniel, do agree with these changes (in particular the __plist_del()
> changes?) and is there anything else missing? It looks like we might be
> near the end of the tunnel and plists are really stabilizing.


__plist_del was a good fix. I attached a patch on "Plist cleanup on RT" to
lkml with what was acceptable to me. A good 60% of Thomas's changes are
unacceptable to me.

Daniel


