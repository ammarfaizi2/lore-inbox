Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965249AbWEaXPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249AbWEaXPm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 19:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965251AbWEaXPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 19:15:41 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:48869 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965249AbWEaXPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 19:15:41 -0400
Date: Thu, 1 Jun 2006 01:16:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Drynoff <pauldrynoff@gmail.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: 2.6.17-rc5-mm1 - output of lock validator
Message-ID: <20060531231602.GA9610@elte.hu>
References: <20060530195417.e870b305.pauldrynoff@gmail.com> <20060530132540.a2c98244.akpm@osdl.org> <20060531181926.51c4f4c5.pauldrynoff@gmail.com> <1149085739.3114.34.camel@laptopd505.fenrus.org> <20060531203823.bc77da92.pauldrynoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060531203823.bc77da92.pauldrynoff@gmail.com>
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


* Paul Drynoff <pauldrynoff@gmail.com> wrote:

> On Wed, 31 May 2006 16:28:59 +0200
> Arjan van de Ven <arjan@linux.intel.com> wrote:
> 
> > On Wed, 2006-05-31 at 18:19 +0400, Paul Drynoff wrote:
> 
> > Make the ne2000 drivers use irqsave, they already disabled 
> > interrupts generally so it is semi redundant, but it'll help the 
> > lock validator at least...
> 
> Yes, this patch fixes situation.

great!

	Ingo
