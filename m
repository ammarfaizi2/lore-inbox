Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWE3WSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWE3WSb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 18:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWE3WSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 18:18:31 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:959 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932525AbWE3WSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 18:18:30 -0400
Date: Wed, 31 May 2006 00:18:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060530221850.GA1764@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <6bffcb0e0605301155h3b472d79h65e8403e7fa0b214@mail.gmail.com> <6bffcb0e0605301157o6b7c5f66q3c9f151cbb4537d5@mail.gmail.com> <20060530194259.GB22742@elte.hu> <6bffcb0e0605301457v9ba284bk75b8b6d14384489a@mail.gmail.com> <20060530220931.GA32759@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530220931.GA32759@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> could you try to 1) disable PREEMPT, 2) apply the -V2 rollup of all 
> fixes so far to 2.6.17-rc5-mm1:
> 
>  http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-rc5-mm1.patch
> 
> ? I'll try your config meanwhile.

PREEMPT wasnt the problem but CONFIG_DEBUG_STACKOVERFLOW (at least). 
There's some other debug option that seems incompatible too - i'm still 
trying to figure out which one.

	Ingo
