Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266986AbTBLKHt>; Wed, 12 Feb 2003 05:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266987AbTBLKHt>; Wed, 12 Feb 2003 05:07:49 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:11392 "EHLO
	bjl1.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S266986AbTBLKHt>; Wed, 12 Feb 2003 05:07:49 -0500
Date: Wed, 12 Feb 2003 10:18:31 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
Message-ID: <20030212101831.GB10422@bjl1.jlokier.co.uk>
References: <629040000.1045013743@flay> <20030212041848.GA9273@bjl1.jlokier.co.uk> <b2cnit$7e6$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2cnit$7e6$1@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> In article <20030212041848.GA9273@bjl1.jlokier.co.uk>,
> Jamie Lokier  <jamie@shareable.org> wrote:
> >
> >A cute and wonderful hack is to use the 6 words in the TSS prior to
> >&tss->es as the trampoline. Now that __switch_to is done in software,
> >those words are not used for anything else.
> 
> No!! 
> 
> That's not cute and wonderful, that's _horrible_.

I meant: the trampoline _stack_ lives in the TSS.

There is no trampoline _code_.

My apologies for poor wording.

-- Jamie
