Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269266AbUJQTYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269266AbUJQTYn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 15:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268447AbUJQTYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 15:24:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:22741 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269272AbUJQTYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 15:24:19 -0400
Date: Sun, 17 Oct 2004 21:24:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Daniel Walker <dwalker@mvista.com>, Bill Huey <bhuey@lnxw.com>,
       Andrew Morton <akpm@osdl.org>, Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
Message-ID: <20041017192445.GA32443@elte.hu>
References: <1097888438.6737.63.camel@krustophenia.net> <1097894120.31747.1.camel@krustophenia.net> <20041016064205.GA30371@elte.hu> <1097917325.1424.13.camel@krustophenia.net> <20041016103608.GA3548@elte.hu> <32801.192.168.1.5.1098018846.squirrel@192.168.1.5> <20041017132107.GA18462@elte.hu> <32793.192.168.1.5.1098023139.squirrel@192.168.1.5> <20041017164743.GA26350@elte.hu> <32792.192.168.1.5.1098039918.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32792.192.168.1.5.1098039918.squirrel@192.168.1.5>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> BTW, stack overflows wasn't supposed to be pin-pointed when one has
> CONFIG_DEBUG_STACKOVERFLOW=y ???

there were some signs of it:

  minicom.cap.5:do_IRQ: stack overflow: 504

	Ingo
