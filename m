Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbVGWAoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbVGWAoq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 20:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVGWAoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 20:44:46 -0400
Received: from [67.70.253.242] ([67.70.253.242]:56334 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262255AbVGWAoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 20:44:44 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: LKML <linux-kernel@vger.kernel.org>, Andrian Bunk <bunk@stusta.de>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Giving developers clue how many testers verified certain kernel version
Date: Sat, 23 Jul 2005 02:44:11 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507230244.11338.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk <at> stusta.de> writes:
> On Thu, Jul 21, 2005 at 09:40:43PM -0500, Alejandro Bonilla wrote:
> > 
> >    How do we know that something is OK or wrong? just by the fact that 
> > it works or not, it doesn't mean like is OK.
> > 
> > There has to be a process for any user to be able to verify and study a 
> > problem. We don't have that yet.

> If the user doesn't notice the difference then there's no problem for 
> him.
Some performance regressions aren't easily noticeable without benchmarks... 
and we've had people claiming unnoticed regressions since 2.6.2 
(http://kerneltrap.org/node/4940)
> If there's a problem the user notices, then the process is to send an 
> email to linux-kernel and/or open a bug in the kernel Bugzilla and 
> follow the "please send the output of foo" and "please test patch bar" 
> instructions.

> What comes nearest to what you are talking about is that you run LTP 
> and/or various benchmarks against every -git and every -mm kernel and 
> report regressions. But this is sinply a task someone could do (and I 
> don't know how much of it is already done e.g. at OSDL), and not 
> something every user could contribute to.

Forgot drivers testing? That is where most of the bugs are hidden, and where 
wide user testing is definitely needed because of the various hardware bugs 
and different configurations existing in real world.

IMHO, I think that publishing statistics about kernel patches downloads would 
be a very Good Thing(tm) to do. Peter, what's your opinion? I think that was 
even talked about at Kernel Summit (or at least I thought of it there), but 
I've not understood if this is going to happen.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
