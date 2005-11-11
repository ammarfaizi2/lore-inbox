Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbVKKSAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbVKKSAW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 13:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbVKKSAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 13:00:21 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:4612 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id S1750987AbVKKSAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 13:00:20 -0500
Date: Fri, 11 Nov 2005 18:00:24 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Pavel Machek <pavel@ucw.cz>, Zachary Amsden <zach@vmware.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
In-Reply-To: <4374D99C.1080006@zytor.com>
Message-ID: <Pine.LNX.4.64N.0511111754060.3793@blysk.ds.pg.gda.pl>
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>
 <20051111103605.GC27805@elf.ucw.cz> <4374D99C.1080006@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2005, H. Peter Anvin wrote:

> I think the 486's that have CR4 are the same that have CPUID, and thus can be
> tested for by the presence of the ID flag.

 That's correct; for our purposes a 486 that would implement CR4 but not 
CPUID would not be interesting anyway, as we don't use CR4 elsewhere but 
for features discovered through CPUID.  And I don't think there's ever 
been an implementation that had CPUID but no CR4.

  Maciej
