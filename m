Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270325AbTHQPdY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 11:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270326AbTHQPdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 11:33:24 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:8915
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S270325AbTHQPdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 11:33:21 -0400
Date: Sun, 17 Aug 2003 17:33:41 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Larry McVoy <lm@bitmover.com>, Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Fwd: Re: Bug Report: 2.4.22-pre5: BUG in page_alloc (fwd)
Message-ID: <20030817153341.GP7862@dualathlon.random>
References: <20030721190226.GA14453@matchmail.com> <20030721194514.GA5803@work.bitmover.com> <20030721212155.GF4677@x30.linuxsymposium.org> <20030721213159.GA7240@work.bitmover.com> <20030721220000.GG4677@x30.linuxsymposium.org> <20030729092821.GC23835@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729092821.GC23835@dualathlon.random>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 29, 2003 at 11:28:21AM +0200, Andrea Arcangeli wrote:
> Peter, any suggestion on this? Larry said it's all on your side, so I
> assume you're running bkcvs yourself, or Larry is already providing you
> a locking mechanism that serializes against bkcvs and that allows you
> to fetch a coherent of the cvs repository. w/o this last locking bit
> that allows to export a coherent copy of the repository, I can't easily
> automate the stuff based on a local repository and I've to switch to the
> remote one, despite having it local is more flexible (and much faster
> for local browsing) and rsync -z is faster.

Any news on this? I'm still looking into a way to rsync a coherenty copy
of the cvs repository.

Andrea
