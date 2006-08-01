Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030376AbWHABh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbWHABh3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 21:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbWHABh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 21:37:29 -0400
Received: from nevyn.them.org ([66.93.172.17]:996 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1030376AbWHABh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 21:37:28 -0400
Date: Mon, 31 Jul 2006 21:37:08 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Albert Cahalan <acahalan@gmail.com>
Cc: torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, ak@suse.de, mingo@elte.hu,
       arjan@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       roland@redhat.com
Subject: Re: ptrace bugs and related problems
Message-ID: <20060801013708.GA25965@nevyn.them.org>
Mail-Followup-To: Albert Cahalan <acahalan@gmail.com>, torvalds@osdl.org,
	alan@lxorguk.ukuu.org.uk, ak@suse.de, mingo@elte.hu,
	arjan@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
	roland@redhat.com
References: <787b0d920607262355x3f669f0ap544e3166be2dca21@mail.gmail.com> <20060727203128.GA26390@nevyn.them.org> <787b0d920607271817u4978d2bdiac261d916971c1b3@mail.gmail.com> <20060728034741.GA3372@nevyn.them.org> <787b0d920607281528w56472db2u81268aad523d5c72@mail.gmail.com> <20060731190018.GA13735@nevyn.them.org> <787b0d920607311708y3642e41cue49cd47ccc39e77d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787b0d920607311708y3642e41cue49cd47ccc39e77d@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 08:08:35PM -0400, Albert Cahalan wrote:
> The execve event is unreliable anyway.
> Thus, it is necessary to use syscall tracing.

You keep saying this "unreliable" thing, and I don't think it means
what you think it means.  It should always be delivered.  When it
isn't, there's a bug.  I don't know of any, unless you're talking about
the thread group issue you just reported.

-- 
Daniel Jacobowitz
CodeSourcery
