Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWFGWMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWFGWMl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 18:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbWFGWMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 18:12:41 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:23199 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932435AbWFGWMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 18:12:40 -0400
Date: Thu, 8 Jun 2006 00:11:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc6-mm1
Message-ID: <20060607221142.GB6287@elte.hu>
References: <20060607104724.c5d3d730.akpm@osdl.org> <200606072354.41443.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606072354.41443.rjw@sisk.pl>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> On Wednesday 07 June 2006 19:47, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm1/
> > 
> > - Many more lockdep updates
> 
> Well, I've got this one (Asus L5D, x86_64 kernel):

could you try the current lock validator combo patch from:

  http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-rc6-mm1.patch

does that fix this for you?

	Ingo
