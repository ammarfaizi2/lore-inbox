Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWE3MM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWE3MM6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 08:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWE3MM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 08:12:58 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:27336 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751426AbWE3MM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 08:12:58 -0400
Date: Tue, 30 May 2006 14:13:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, jketreno@linux.intel.com,
       yi.zhu@intel.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
Message-ID: <20060530121315.GA9337@elte.hu>
References: <20060529212109.GA2058@elte.hu> <20060530091415.GA13341@ens-lyon.fr> <1148984787.3636.45.camel@laptopd505.fenrus.org> <20060530114257.GA17628@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530114257.GA17628@ens-lyon.fr>
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


* Benoit Boissinot <benoit.boissinot@ens-lyon.org> wrote:

> It is probably related, but I got this in my log too:
> 
> BUG: warning at kernel/softirq.c:86/local_bh_disable()

this one is harmless, you can ignore it. (already sent a patch to remove 
the WARN_ON)

	Ingo
