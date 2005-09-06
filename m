Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbVIFUch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbVIFUch (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 16:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbVIFUch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 16:32:37 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:23185
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750892AbVIFUch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 16:32:37 -0400
Date: Tue, 06 Sep 2005 13:32:08 -0700 (PDT)
Message-Id: <20050906.133208.68854265.davem@davemloft.net>
To: ak@suse.de
Cc: discuss@x86-64.org, Terrence.Miller@sun.com, jakub@redhat.com,
       bunk@stusta.de, matz@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [discuss] [2.6 patch] include/asm-x86_64 "extern inline" ->
 "static inline"
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200509062223.50747.ak@suse.de>
References: <20050905184740.GF7403@devserv.devel.redhat.com>
	<431DD7BE.7060504@Sun.COM>
	<200509062223.50747.ak@suse.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
Date: Tue, 6 Sep 2005 22:23:50 +0200

> I don't think the functionality of having single copies in case 
> an out of line version was needed was ever required by the Linux kernel.

Alpha does, exactly for the kind of case this gcc inlining feature was
designed for.
