Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263301AbUFXAcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbUFXAcw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 20:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263188AbUFXAcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 20:32:52 -0400
Received: from holomorphy.com ([207.189.100.168]:29830 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263301AbUFXAcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 20:32:51 -0400
Date: Wed, 23 Jun 2004 17:32:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [oom]: [0/4] fix OOM deadlock running OAST
Message-ID: <20040624003249.GM1552@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <0406231407.HbLbJbXaHbKbWa5aJb1a4aKb0a3aKb1a0a2aMbMbYa3aLbMb3aJbWaJbXaMbLb1a342@holomorphy.com> <20040623151659.70333c6d.akpm@osdl.org> <20040623223146.GG1552@holomorphy.com> <20040623153758.40e3a865.akpm@osdl.org> <20040623230730.GJ1552@holomorphy.com> <20040623163819.013c8585.akpm@osdl.org> <20040624000308.GK1552@holomorphy.com> <20040623171818.39b73d52.akpm@osdl.org> <20040624002651.GL1552@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624002651.GL1552@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 05:26:51PM -0700, William Lee Irwin III wrote:
> Then it sounds like the smaller fix below may be better for you.

Also, as we're fixing this a different way, could you clarify for me
which of the pieces of the original fix or related things (e.g. the
zone->all_unreclaimable stuff, yanking PG_wired stuff off the LRU,
maybe more) you wanted me to rework and send back in later?

I'm heading out for an hour or so, so I'll be slightly delayed getting
those things back to you.


-- wli
