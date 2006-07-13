Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbWGMDP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWGMDP4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 23:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWGMDP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 23:15:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38356 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932491AbWGMDPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 23:15:55 -0400
Date: Wed, 12 Jul 2006 20:12:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
In-Reply-To: <20060713030402.GC9102@opteron.random>
Message-ID: <Pine.LNX.4.64.0607122010060.5623@g5.osdl.org>
References: <20060630014050.GI19712@stusta.de> <p73wtain80h.fsf@verdi.suse.de>
 <20060712210732.GA10182@elte.hu> <200607130006.12705.ak@suse.de>
 <20060713030402.GC9102@opteron.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Jul 2006, Andrea Arcangeli wrote:
> 
> What Ingo complains about is the fact somebody could be selling a
> patented mp3 player that uses alsa. Should alsa be rejected from the
> kernel? Does that mean alsa has anything to do with the mp3 patent?

ALSA is used for other things _too_.

I don't think SECCOMP is wrong per se, but I do believe that if other 
approaches become more popular, and the only user of SECCOMP is not GPL'd 
and uses some patented stuff, then we should seriously look at the other 
interfaces (eg the extended ptrace).

Does anybody actually really _use_ SECCOMP outside of the patented stuff?

		Linus
