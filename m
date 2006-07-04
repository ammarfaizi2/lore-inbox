Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWGDU0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWGDU0E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 16:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWGDU0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 16:26:04 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:30684 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932388AbWGDU0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 16:26:02 -0400
Date: Tue, 4 Jul 2006 22:21:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Fabio Comolli <fabio.comolli@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       mingo@redhat.com, Pavel Machek <pavel@ucw.cz>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.17-mm5: lockdep prevents suspend to disk
Message-ID: <20060704202115.GA16842@elte.hu>
References: <b637ec0b0607041258j36007132kdb7dbca1fa8f7dd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b637ec0b0607041258j36007132kdb7dbca1fa8f7dd5@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5033]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fabio Comolli <fabio.comolli@gmail.com> wrote:

> Hi.
> In short:
> 
> * 2.6.17-mm5 (plus hotfix)  suspends/resume to disk correctly
> * adding lockdep testsuite breaks it
> 
> Extract from dmesg:

seems to be caused by:

> ACPI Error (exmutex-0283): Cannot release Mutex [BATM],
> incorrect SyncLevel [20060623]

?

	Ingo
