Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268423AbUHQUxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268423AbUHQUxu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 16:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268427AbUHQUxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 16:53:15 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:13447 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S268423AbUHQUxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 16:53:09 -0400
Date: Tue, 17 Aug 2004 22:52:55 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
Message-ID: <20040817205255.GA32252@k3.hellgate.ch>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Ingo Molnar <mingo@elte.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	Florian Schmidt <mista.tapas@gmx.net>
References: <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe> <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe> <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu> <1092612264.867.9.camel@krustophenia.net> <20040816080745.GA18406@k3.hellgate.ch> <1092696835.13981.61.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092696835.13981.61.camel@krustophenia.net>
X-Operating-System: Linux 2.6.8-rc3-mm1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004 18:53:56 -0400, Lee Revell wrote:
> What do you think of Ingo's solution of trying to move the problematic
> call to mdio_read out of the spinlocked section?  It does seem that the

Can't comment on that, I missed it. I am aware that locking in via-rhine
needs work, though, it's one of the things I haven't touched.

> awfully long time.  In a live audio setting you would actually get lots
> of media events.

Don't trip over the network cables. Duh.

Roger
