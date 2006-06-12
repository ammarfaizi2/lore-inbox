Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWFLOg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWFLOg5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 10:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbWFLOg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 10:36:57 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:36745 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751347AbWFLOg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 10:36:56 -0400
Date: Mon, 12 Jun 2006 16:35:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Duncan Sands <baldrick@free.fr>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Anton Altaparmakov <aia21@cantab.net>
Subject: Re: NTFS possible circular locking deadlock (Was: Re: 2.6.17-rc6-mm1)
Message-ID: <20060612143555.GA24315@elte.hu>
References: <20060607104724.c5d3d730.akpm@osdl.org> <200606072354.41443.rjw@sisk.pl> <20060607221142.GB6287@elte.hu> <200606081206.42852.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606081206.42852.baldrick@free.fr>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5075]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Duncan Sands <baldrick@free.fr> wrote:

> With the combo patch applied:
> 
> [   58.778002] NTFS driver 2.1.27 [Flags: R/W MODULE].
> [   58.891035]
> [   58.891039] =====================================================
> [   58.913817] [ BUG: possible circular locking deadlock detected! ]

this should be fixed in the latest combo patch ontop of -rc6-mm2:

  http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-rc6-mm2.patch

	Ingo
