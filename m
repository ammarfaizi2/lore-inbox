Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267301AbUHPASX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267301AbUHPASX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 20:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267312AbUHPAP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 20:15:56 -0400
Received: from pop.gmx.net ([213.165.64.20]:41697 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267298AbUHPAPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 20:15:23 -0400
X-Authenticated: #4399952
Date: Mon, 16 Aug 2004 02:25:54 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
Message-Id: <20040816022554.16c3c84a@mango.fruits.de>
In-Reply-To: <20040815115649.GA26259@elte.hu>
References: <20040726204720.GA26561@elte.hu>
	<20040729222657.GA10449@elte.hu>
	<20040801193043.GA20277@elte.hu>
	<20040809104649.GA13299@elte.hu>
	<20040810132654.GA28915@elte.hu>
	<20040812235116.GA27838@elte.hu>
	<1092382825.3450.19.camel@mindpipe>
	<20040813104817.GI8135@elte.hu>
	<1092432929.3450.78.camel@mindpipe>
	<20040814072009.GA6535@elte.hu>
	<20040815115649.GA26259@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Aug 2004 13:56:49 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> i've uploaded the -P0 patch:
> 
>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P0

I haven't tried this patch yet, but i have a question regarding the
mlockall issue:

Jackd also uses IPC mechnisms for remote procedure calls [i think,
please correct me] and makes heavy use of shared memory. Might
mlock(all) have influence of this? is jackd maybe producing xruns
because some IPC stuff blocks when mlockall is used?

I'm just guessing wildly and uneducatedly..

-- 
Palimm Palimm!
http://affenbande.org/~tapas/

