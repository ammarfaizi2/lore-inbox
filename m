Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbTENUcA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbTENUcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:32:00 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:48798 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262720AbTENUb5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:31:57 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 14 May 2003 13:43:45 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Ulrich Drepper <drepper@redhat.com>, Dave Jones <davej@codemonkey.org.uk>,
       Christopher Hoover <ch@murgatroid.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
In-Reply-To: <Pine.LNX.4.44.0305141246180.27329-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.55.0305141342030.4539@bigblue.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0305141246180.27329-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003, Linus Torvalds wrote:

>
> On Wed, 14 May 2003, Ulrich Drepper wrote:
> >
> > Current == current development.  LinuxThreads is not developed anymore
> > and with nptl futexes are mandatory.
>
> Yes, I'm also not very eager to make "core functionality" a config option.
> The confusion with the INPUT layer config options was mighty, and none of
> it pleasant. And the *BSD's have historically had totally stupid problems
> with programs like Wine etc requireing kernel recompiles just because they
> made code functionality like vm86 mode or LDT support be a config option.
>
> I don't see the point in dropping futexes except perhaps in a very
> controlled embedded environment, but if that is the case, then a PC config
> should just force it to "y" and not even ask the user.
>
> We absolutely do NOT want the situation where a program will not work just
> because the user forgot some config option that mostly isn't needed.

Not only. Like Ulrich was saying, the config documentation should heavily
warn the wild config guy about the consequences of a 'NO' over there.



- Davide

