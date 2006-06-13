Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932884AbWFMEtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932884AbWFMEtk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 00:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932882AbWFMEtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 00:49:40 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:63129
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932879AbWFMEtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 00:49:39 -0400
Date: Mon, 12 Jun 2006 21:49:48 -0700 (PDT)
Message-Id: <20060612.214948.124554804.davem@davemloft.net>
To: ak@suse.de
Cc: jeremy@goop.org, lkml@rtr.ca, mpm@selenic.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Using netconsole for debugging suspend/resume
From: David Miller <davem@davemloft.net>
In-Reply-To: <200606130547.49624.ak@suse.de>
References: <200606121746.34880.ak@suse.de>
	<448DDBD9.6030900@goop.org>
	<200606130547.49624.ak@suse.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
Date: Tue, 13 Jun 2006 05:47:49 +0200

> I've been playing with the idea of writing "early1394" that just
> turns the DMA controller on as early as possible similar to earlyprintk
> on the target. Then it would be possible to use it for early
> debugging too. But so far it's not done yet.

Does this raw1394 thing with firescope just assume DMA address ==
physical address?  How would it work to access all of physical
memory properly on IOMMU platforms?
