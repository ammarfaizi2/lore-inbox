Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVFTSly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVFTSly (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 14:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVFTSly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 14:41:54 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:414 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261423AbVFTSlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:41:52 -0400
Subject: Re: A Great Idea (tm) about reimplementing NLS.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jeremy Maitin-Shepard <jbms@cmu.edu>,
       Patrick McFarland <pmcfarland@downeast.net>,
       Alexey Zaytsev <alexey.zaytsev@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050619175503.GA3193@elf.ucw.cz>
References: <f192987705061303383f77c10c@mail.gmail.com>
	 <f192987705061310202e2d9309@mail.gmail.com>
	 <1118690448.13770.12.camel@localhost.localdomain>
	 <200506152149.06367.pmcfarland@downeast.net>
	 <20050616023630.GC9773@thunk.org> <87y89a7wfn.fsf@jbms.ath.cx>
	 <20050616143727.GC10969@thunk.org>  <20050619175503.GA3193@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119292723.3279.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Jun 2005 19:38:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-06-19 at 18:55, Pavel Machek wrote:
> Actually the day we have rm utf-8-ed, we have a problem. Someone will
> create two files that have same utf name, encoded differently, and
> will be in trouble. Remember old > \* "hack"? utf-8 makes variation
> possible...

They are different to POSIX as they are different byte sequences
> 
> If we are serious about utf-8 support in ext3, we should return
> -EINVAL if someone passes non-canonical utf-8 string.

That would ironically not be standards compliant

