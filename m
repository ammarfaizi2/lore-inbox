Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbTEFAId (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 20:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbTEFAId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 20:08:33 -0400
Received: from are.twiddle.net ([64.81.246.98]:13205 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S261259AbTEFAIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 20:08:32 -0400
Date: Mon, 5 May 2003 17:21:00 -0700
From: Richard Henderson <rth@twiddle.net>
To: Mark Kettenis <kettenis@chello.nl>
Cc: David.Mosberger@acm.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix vsyscall unwind information
Message-ID: <20030506002100.GB10921@twiddle.net>
Mail-Followup-To: Mark Kettenis <kettenis@chello.nl>,
	David.Mosberger@acm.org, linux-kernel@vger.kernel.org
References: <20030502004014$08e2@gated-at.bofh.it> <20030503210015$292c@gated-at.bofh.it> <20030504063010$279f@gated-at.bofh.it> <ugade16g78.fsf@panda.mostang.com> <20030505074248.GA7812@twiddle.net> <16054.32214.804891.702812@panda.mostang.com> <20030505163444.GB9342@twiddle.net> <86d6ixdm6q.fsf@elgar.kettenis.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86d6ixdm6q.fsf@elgar.kettenis.dyndns.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 01:10:37AM +0200, Mark Kettenis wrote:
> Unfortunately, GDB needs to be able to recognize signal trampolines in
> order to be able to single step correctly when a signal arrives.

If it actually used the dwarf2 unwind information as written,
I wouldn't expect this to be true.

> Anyway, signal trampolines could be marked with a special augmentation
> in their CIE.

I'd prefer not, if at all possible.


r~
