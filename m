Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262735AbVBBQxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbVBBQxb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 11:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbVBBQwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 11:52:50 -0500
Received: from mx2.elte.hu ([157.181.151.9]:43677 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262299AbVBBQwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 11:52:36 -0500
Date: Wed, 2 Feb 2005 17:51:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: pageexec@freemail.hu
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Message-ID: <20050202165151.GA1804@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* pageexec@freemail.hu <pageexec@freemail.hu> wrote:

> your concerns would be valid if this was impossible to achieve by an
> exploit, sadly, you'd be wrong too, it's possible to force an
> exploited application to call something like
> dl_make_stack_executable() and then execute the shellcode. [...]

and how do you force a program to call that function and then to execute
your shellcode? In other words: i challenge you to show a working
(simulated) exploit on Fedora (on the latest fc4 devel version, etc.) 
that does that. 

You can simulate the overflow itself so no need to find any real
application vulnerability, but show me _working code_ (or a convincing
description) that can call glibc's do_make_stack_executable() (or the
'many ways of doing this'), _and_ will end up executing your shell code
as well.

if you can do this i fully accept there's a problem.

	Ingo
