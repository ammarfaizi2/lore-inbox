Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbWE3WJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWE3WJP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 18:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWE3WJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 18:09:14 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:38788 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932518AbWE3WJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 18:09:13 -0400
Date: Wed, 31 May 2006 00:09:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060530220931.GA32759@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <6bffcb0e0605301155h3b472d79h65e8403e7fa0b214@mail.gmail.com> <6bffcb0e0605301157o6b7c5f66q3c9f151cbb4537d5@mail.gmail.com> <20060530194259.GB22742@elte.hu> <6bffcb0e0605301457v9ba284bk75b8b6d14384489a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0605301457v9ba284bk75b8b6d14384489a@mail.gmail.com>
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


* Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:

> >  http://redhat.com/~mingo/lockdep-patches/latency-tracing-lockdep.patch
> >
> >just apply it ontop of your current tree and accept all the new .config
> >options as the kernel suggests them to you.
> 
> I can't boot with that patch. I even don't see "Uncompressing
> Linux..." - machine reboots.
> I have 2.6.17-rc5-mm1 +
> genirq-cleanup-remove-irq_descp-fix.patch
> lock-validator-irqtrace-support-non-x86-architectures.patch
> lock-validator-special-locking-sb-s_umount-2-fix.patch
> from hot fixes
> +
> Arjan's net/ipv4/igmp.c patch.

could you try to 1) disable PREEMPT, 2) apply the -V2 rollup of all 
fixes so far to 2.6.17-rc5-mm1:

 http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-rc5-mm1.patch

? I'll try your config meanwhile.

	Ingo
