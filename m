Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWCMJ1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWCMJ1j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 04:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWCMJ1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 04:27:39 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:23229 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932390AbWCMJ1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 04:27:38 -0500
Date: Mon, 13 Mar 2006 10:25:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-rt1
Message-ID: <20060313092501.GA10931@elte.hu>
References: <20060312220218.GA3469@elte.hu> <6bffcb0e0603121517s79f6a0e9i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0603121517s79f6a0e9i@mail.gmail.com>
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

> Hi,
> 
> On 12/03/06, Ingo Molnar <mingo@elte.hu> wrote:
> > i have released the 2.6.16-rc6-rt1 tree, which can be downloaded from
> > the usual place:
> >
> >    http://redhat.com/~mingo/realtime-preempt/
> 
> make modules_install
> [snip]
> if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map  2.
> 6.16-rc6-rt1; fi
> WARNING: /lib/modules/2.6.16-rc6-rt1/kernel/sound/core/snd.ko needs
> unknown symbol rt_read_lock

ok - i have applied Jan Altenberg's patch (which should fix this 
problem), and have released 2.6.16-rc6-rt2.

	Ingo
