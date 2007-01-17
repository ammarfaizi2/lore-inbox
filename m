Return-Path: <linux-kernel-owner+w=401wt.eu-S932071AbXAQIvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbXAQIvP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 03:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbXAQIvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 03:51:15 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:45360 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932071AbXAQIvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 03:51:14 -0500
Date: Wed, 17 Jan 2007 09:49:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/11] Fix CONFIG_COMPAT_VDSO
Message-ID: <20070117084947.GA19093@elte.hu>
References: <20070114053140.351701800E5@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070114053140.351701800E5@magilla.sf.frob.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roland McGrath <roland@redhat.com> wrote:

> I wouldn't mind if CONFIG_COMPAT_VDSO went away entirely. But if it's 
> there, it should work properly.  Currently it's quite haphazard: both 
> real vma and fixmap are mapped, both are put in the two different AT_* 
> slots, sysenter returns to the vma address rather than the fixmap 
> address, and core dumps yet are another story.

i think your patches #1...#7 are must-haves for v2.6.20, while #8-#11 
could be delayed to v2.6.21?

	Ingo
