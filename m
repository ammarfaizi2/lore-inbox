Return-Path: <linux-kernel-owner+w=401wt.eu-S1754562AbWLRUmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562AbWLRUmP (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 15:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754563AbWLRUmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 15:42:15 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55435 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754562AbWLRUmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 15:42:14 -0500
Date: Mon, 18 Dec 2006 21:40:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug: isicom: kobject_add failed for ttyM0 with -EEXIST
Message-ID: <20061218204006.GA7590@elte.hu>
References: <20061218155714.GA21823@elte.hu> <4586C882.6090906@gmail.com> <20061218200050.GB339@elte.hu> <4586FAA1.8080904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4586FAA1.8080904@gmail.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jiri Slaby <jirislaby@gmail.com> wrote:

> Ingo Molnar wrote:
> > * Jiri Slaby <jirislaby@gmail.com> wrote:
> > 
> >> Ingo Molnar wrote:
> >>> allyesconfig bzImage bootup produced 33 warning messages, of which the 
> >>> first couple are attached below.
> >> With which kernel? mxser had ttyM for a long time, it should be fixed 
> >> in 2.6.20-rc1.
> > 
> > current -git.
> 
> It's rather impossible. Aren't you seeked somewhere (I'm in 
> 825020c3866e7312947e17a0caa9dd1a5622bafc now)?

indeed it was a v2.6.19 base - sorry! I'll re-report if there's any 
problem left.

	Ingo

