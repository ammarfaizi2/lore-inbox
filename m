Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbVKOQvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbVKOQvx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbVKOQvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:51:22 -0500
Received: from main.gmane.org ([80.91.229.2]:21434 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964924AbVKOQvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:51:19 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Tue, 15 Nov 2005 11:46:30 -0500
Message-ID: <dld3cs$1sh$1@sea.gmane.org>
References: <58MJb-2Sn-37@gated-at.bofh.it> <58NvO-46M-23@gated-at.bofh.it> <58Rpx-1m6-11@gated-at.bofh.it> <58UGF-6qR-27@gated-at.bofh.it> <58UQf-6Da-3@gated-at.bofh.it> <437933B6.1000503@shaw.ca> <1132020468.27215.25.camel@mindpipe> <20051115032819.GA5620@redhat.com> <43795575.9010904@wolfmountaingroup.com> <20051115050658.GA13660@redhat.com> <43797E05.5090107@wolfmountaingroup.com> <17273.34218.334118.264701@cse.unsw.edu.au> <4379846E.2070006@wolfmountaingroup.com> <20051115141851.18c2c276.grundig@teleline.es> <1132061045.2822.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ool-18b913a0.dyn.optonline.net
User-Agent: KNode/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> the same as 2.4 effectively. 2.6 also has (and I wish it becomes "had"
> soon) an option to get 6Kb effective stack space instead. This is an
> increase of 2Kb compared to 2.4.

It has been asked couple of times before in this context and no one cared to
answer:

Using 4k stacks may have advantages, but what compelling reasons are there
to drop the choice of 4k/8k stacks? You can make 4k stacks default, but why
throw away the option of 8k stacks, especially since the impact of this
option on the kernel implementation is very little?

Giri

