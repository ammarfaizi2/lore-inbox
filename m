Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWHTTpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWHTTpI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 15:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWHTTpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 15:45:07 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:14298
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751179AbWHTTpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 15:45:06 -0400
Date: Sun, 20 Aug 2006 12:45:16 -0700 (PDT)
Message-Id: <20060820.124516.41639882.davem@davemloft.net>
To: ak@suse.de
Cc: solar@openwall.com, wtarreau@hera.kernel.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] getsockopt() early argument sanity checking
From: David Miller <davem@davemloft.net>
In-Reply-To: <200608201034.43588.ak@suse.de>
References: <20060819230532.GA16442@openwall.com>
	<200608201034.43588.ak@suse.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
Date: Sun, 20 Aug 2006 10:34:43 +0200

> Doing a check that is inherently racy everywhere doesn't seem like a
> security improvement to me. If there is really a length checking bug
> somewhere it needs to be fixed in a race-free way. If not then there
> is no need for a change.

Totally agreed, this change makes no sense on every level.
