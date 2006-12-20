Return-Path: <linux-kernel-owner+w=401wt.eu-S1754807AbWLTPsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807AbWLTPsP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 10:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754812AbWLTPsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 10:48:15 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:61014 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807AbWLTPsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 10:48:15 -0500
Date: Wed, 20 Dec 2006 17:48:09 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Dave Jones <davej@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [patch] x86_64: fix boot time hang in detect_calgary()
Message-ID: <20061220154809.GL30145@rhun.ibm.com>
References: <20061220105332.GA20922@elte.hu> <20061220152828.GF31335@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220152828.GF31335@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 10:28:28AM -0500, Dave Jones wrote:

> Good job tracking this down.  I saw someone get bit by probably this
> same bug a few days ago.  Whilst on the subject though, can we do
> something about the printk ?

Calgary can't be built as a module. I agree that being quiet when we
don't find the HW is the appropriate thing to do. I'll push a patch to
make this KERN_DEBUG in the next batch of updates.

Cheers,
Muli
