Return-Path: <linux-kernel-owner+w=401wt.eu-S932228AbXAFVsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbXAFVsV (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 16:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbXAFVsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 16:48:21 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:56511 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932228AbXAFVsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 16:48:20 -0500
Date: Sat, 6 Jan 2007 22:45:05 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Marcus Meissner <meissner@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Dave Jones <davej@codemonkey.org.uk>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: revert PIE randomization?
Message-ID: <20070106214505.GA8904@elte.hu>
References: <Pine.LNX.4.64.0701062005001.22171@blonde.wat.veritas.com> <Pine.LNX.4.64.0701061303320.3661@woody.osdl.org> <20070106210826.GA31518@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070106210826.GA31518@suse.de>
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


* Marcus Meissner <meissner@suse.de> wrote:

> > You're right. I'm inclined to just revert it, modulo some comments 
> > from others. Marcus?
> 
> After thinking about this, yes.
> 
> I would rather have a working range used here (perhaps like Hugh 
> suggested), but feel free to revert the original patch if you are not 
> confident with it.

i'm wondering why you had to try to reinvent the wheel, instead of 
picking up exec-shield's remaining bits of randomization implementation 
from Fedora, which was tested for a long time and achieves PIE 
randomization and more?

	Ingo
