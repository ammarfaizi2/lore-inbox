Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbVAPDLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbVAPDLS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 22:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVAPDLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 22:11:18 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:23240 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262410AbVAPDLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 22:11:16 -0500
Date: Sun, 16 Jan 2005 04:11:11 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Karim Yaghmour <karim@opersys.com>
cc: tglx@linutronix.de, Tim Bird <tim.bird@am.sony.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] Instrumentation (was Re: 2.6.11-rc1-mm1)
In-Reply-To: <41E9CCEF.50401@opersys.com>
Message-ID: <Pine.LNX.4.61.0501160352130.6118@scrub.home>
References: <20050114002352.5a038710.akpm@osdl.org> 
 <1105742791.13265.3.camel@tglx.tec.linutronix.de>  <41E8543A.8050304@am.sony.com>
 <1105794499.13265.247.camel@tglx.tec.linutronix.de> <41E9CCEF.50401@opersys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 15 Jan 2005, Karim Yaghmour wrote:

> In addition, and this is a very important issue, quite a few
> kernel developers mistook LTT for a kernel debugging tool, which
> it was never meant to be. When, in fact, if you ask those who have
> looked at using it for that purpose (try Marcelo or Andrea) you will
> see that they didn't find it to be appropriate for them. And
> rightly so, it was never meant for that purpose. Even lately, when
> I suggested Ingo try using relayfs instead of his custom tracing
> code for his preemption work, he looked at it and said that it
> wasn't suited, but would consider reusing parts of it if it were
> in the kernel.

Well, that's really a core problem. We don't want to duplicate 
infrastructure, which practically does the same. So if relayfs isn't 
usable in this kind of situation, it really raises the question whether 
relayfs is usable at all. We need to make relayfs generally usable, 
otherwise it will join the fate of devfs.

bye, Roman
