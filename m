Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264330AbUFCOnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264330AbUFCOnB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 10:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265539AbUFCOi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 10:38:28 -0400
Received: from [65.39.167.249] ([65.39.167.249]:31200 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S265405AbUFCOgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 10:36:46 -0400
Date: Thu, 3 Jun 2004 10:36:45 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
In-Reply-To: <20040602205025.GA21555@elte.hu>
Message-ID: <Pine.LNX.4.58.0406031031480.14817@innerfire.net>
References: <20040602205025.GA21555@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  kernel tried to access NX-protected page - exploit attempt? (uid: 500)
>  Unable to handle kernel paging request at virtual address f78d0f40
>   printing eip:
>  ...

Just a small nitpick...

Can you please drop the "- exploit attempt" from the error?  Buffer
overflows aren't always exploits.

I already have a problem with jumpy users to blame everything on "hackers"
I'd much rather have someone qualified come to that conclusion rather than
the kernel making a bad guess at it.

	Gerhard


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
