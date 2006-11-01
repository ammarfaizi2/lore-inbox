Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752547AbWKAXKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbWKAXKH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752550AbWKAXKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:10:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21970 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752547AbWKAXKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:10:05 -0500
Date: Wed, 1 Nov 2006 15:09:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Gautham Shenoy <ego@in.ibm.com>
Subject: Re: Remove hotplug cpu crap from cpufreq.
In-Reply-To: <20061101225925.GA17363@redhat.com>
Message-ID: <Pine.LNX.4.64.0611011507480.25218@g5.osdl.org>
References: <20061101225925.GA17363@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Nov 2006, Dave Jones wrote:
>
> I've had it with this stuff.  For months, we've had various warnings
> popping up from this code (which was clearly half-baked at best when it
> went in).
> 
> Until someone steps up who actually gives a damn about fixing it, can
> we just rip this crap out so I stop getting mails from users who couldn't
> care less about CPU hotplug anyway?

Hmm. People _have_ given a damn, and I think you were even cc'd.

Did you take a look at the 5-patch (or was it 6?) series by Gautham R 
Shenoy <ego@in.ibm.com>? I'm cc'ing him, in case you weren't on the 
original list, and he should talk to you ;)

Right now, for 2.6.19, I'd prefer to not touch that mess unless there are 
known conditions that actually cause more problems than just stupid 
warnings..

		Linus
