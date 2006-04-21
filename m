Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWDUAVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWDUAVW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 20:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWDUAVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 20:21:22 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:59359
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932174AbWDUAVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 20:21:21 -0400
Date: Thu, 20 Apr 2006 17:20:58 -0700 (PDT)
Message-Id: <20060420.172058.43978403.davem@davemloft.net>
To: piet@bluelane.com
Cc: axboe@suse.de, torvalds@osdl.org, diegocg@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1145569031.25127.64.camel@piet2.bluelane.com>
References: <20060420.122647.03915644.davem@davemloft.net>
	<20060420193430.GH4717@suse.de>
	<1145569031.25127.64.camel@piet2.bluelane.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Piet Delaney <piet@bluelane.com>
Date: Thu, 20 Apr 2006 14:37:11 -0700

> What about marking the pages Read-Only while it's being used by the
> kernel and if the user tries to write into them letting the VM dup 
> the page with the COW code?

That's historically how you kill performance.
