Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWFMVUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWFMVUA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 17:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWFMVUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 17:20:00 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:52658 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932277AbWFMVT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 17:19:59 -0400
Date: Tue, 13 Jun 2006 23:18:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Miles Lane <miles.lane@gmail.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.17-rc6-mm1 -- BUG: possible circular locking deadlock detected!
Message-ID: <20060613211858.GA31051@elte.hu>
References: <20060610075954.GA30119@elte.hu> <Pine.LNX.4.64.0606100916050.25777@hermes-1.csi.cam.ac.uk> <20060611053154.GA8581@elte.hu> <Pine.LNX.4.64.0606110739310.3726@hermes-1.csi.cam.ac.uk> <20060612083117.GA29026@elte.hu> <1150102041.24273.15.camel@imp.csi.cam.ac.uk> <20060612094011.GA32640@elte.hu> <1150107897.24273.25.camel@imp.csi.cam.ac.uk> <20060612105621.GA10887@elte.hu> <a44ae5cd0606122241nd24a83as9c4ff10d3539260b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44ae5cd0606122241nd24a83as9c4ff10d3539260b@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Miles Lane <miles.lane@gmail.com> wrote:

> if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F
> System.map  2.6.17-rc6-mm2-lockdep; fi
> WARNING: /lib/modules/2.6.17-rc6-mm2-lockdep/kernel/fs/ntfs/ntfs.ko
> needs unknown symbol lockdep_on
> WARNING: /lib/modules/2.6.17-rc6-mm2-lockdep/kernel/fs/ntfs/ntfs.ko
> needs unknown symbol lockdep_off

oops - please re-download the combo patch, i fixed this one.

	Ingo
