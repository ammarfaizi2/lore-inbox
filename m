Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbVLFXZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbVLFXZK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 18:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbVLFXZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 18:25:09 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:56738
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030285AbVLFXZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 18:25:08 -0500
Date: Tue, 06 Dec 2005 15:25:05 -0800 (PST)
Message-Id: <20051206.152505.71096177.davem@davemloft.net>
To: greearb@candelatech.com
Cc: pavel@suse.cz, jbenc@suse.cz, hch@infradead.org, josejx@gentoo.org,
       mbuesch@freenet.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Broadcom 43xx first results
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <4395BFBB.8060304@candelatech.com>
References: <20051205211107.61941ab9@griffin.suse.cz>
	<20051206150909.GB1999@elf.ucw.cz>
	<4395BFBB.8060304@candelatech.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>
Date: Tue, 06 Dec 2005 08:43:39 -0800

> Merge now even if it breaks the current tree?

DCCP is a good counter example, zero --> some functionality is
always preferred.  Our DCCP stack is far from being finished, but
it is in there and getting polished and maintained like everything
else in the upstream tree.

And once it's in there, we can review small patches that add new
functionality not this behemouth "here's the whole thing" jumbo
patch that nobody will want to review.
