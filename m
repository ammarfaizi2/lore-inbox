Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWIXIBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWIXIBY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 04:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWIXIBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 04:01:24 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:24283 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751405AbWIXIBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 04:01:23 -0400
Date: Sun, 24 Sep 2006 09:59:44 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Miller <davem@davemloft.net>
cc: samuel.thibault@ens-lyon.org, sparclinux@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] no SA_NODEFER on sparc?
In-Reply-To: <20060923.173924.78710069.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0609240958550.28459@yvahk01.tjqt.qr>
References: <20060908000602.GJ8569@bouh.residence.ens-lyon.fr>
 <20060923.173924.78710069.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I noticed that the sparc arch misses a definition for SA_NODEFER. Is
>> that on purpose?  If not, here is a patch for fixing this.

BTW, some SA_* constants have been superceded by IRQF_* in the kernel, 
so you might want to check the new ones.


Jan Engelhardt
-- 
