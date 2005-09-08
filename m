Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbVIHUnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbVIHUnF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 16:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbVIHUnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 16:43:05 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:35209
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751382AbVIHUnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 16:43:04 -0400
Date: Thu, 08 Sep 2005 13:42:59 -0700 (PDT)
Message-Id: <20050908.134259.51218842.davem@davemloft.net>
To: torvalds@osdl.org
Cc: rmk+lkml@arm.linux.org.uk, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, davem@redhat.com, akpm@osdl.org
Subject: Re: Serial maintainership
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0509081333450.3039@g5.osdl.org>
References: <20050908212236.A19542@flint.arm.linux.org.uk>
	<20050908.132634.88719733.davem@davemloft.net>
	<Pine.LNX.4.58.0509081333450.3039@g5.osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Thu, 8 Sep 2005 13:39:35 -0700 (PDT)

> So it's certainly a valid optimization to know that the arguments aren't
> even evaluated, and thus it's sometimes really wrong to change a macro
> into an inline function.

Ok, I'll revert the patch and fix the sunsab.c driver as
Russell indicated.  So much for type checking...
