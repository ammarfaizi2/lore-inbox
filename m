Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWFBUxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWFBUxM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWFBUxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:53:12 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:26593 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964893AbWFBUxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:53:10 -0400
Date: Fri, 2 Jun 2006 22:53:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.17-rc5-mm2
Message-ID: <20060602205332.GA5022@elte.hu>
References: <20060601014806.e86b3cc0.akpm@osdl.org> <986ed62e0606011758w348080ebn6e8430ec9e5b2ed3@mail.gmail.com> <20060601183836.d318950e.akpm@osdl.org> <986ed62e0606020614j363bd71bn7d1fba23b78571f3@mail.gmail.com> <20060602142009.GA10236@elte.hu> <986ed62e0606021101t6701d095ycd29c91885aaeec9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <986ed62e0606021101t6701d095ycd29c91885aaeec9@mail.gmail.com>
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


* Barry K. Nathan <barryn@pobox.com> wrote:

> I'm doing building the kernel, but I haven't been able to boot it yet: 
> This system boots the kernel off floppy disks, and under 
> 2.6.17-rc5-mm2, the floppy drive no longer works! The disk spins but 
> the kernel can't read any of the disk's sectors, even for other 
> known-working floppies. I'll have to boot back into 2.6.17-rc4-mm3 
> before I can copy the new kernel onto a disk and boot from it. That 
> will take me a couple of minutes, although I have to go to school in 
> under an hour so I might not get to it until later today.

does it get any better if you remove:

http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/broken-out/lock-validator-floppyc-irq-release-fix.patch

?

	Ingo
