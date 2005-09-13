Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbVIMX3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbVIMX3i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 19:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVIMX3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 19:29:38 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:58058
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932519AbVIMX3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 19:29:37 -0400
Date: Tue, 13 Sep 2005 16:29:35 -0700 (PDT)
Message-Id: <20050913.162935.53822111.davem@davemloft.net>
To: chrisw@osdl.org
Cc: andystewart@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.13 BUG tg3.c:2805 = crash (this one isn't tainted)
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050913222830.GG7991@shell0.pdx.osdl.net>
References: <43263CDC.1010604@comcast.net>
	<43264C1C.9030207@comcast.net>
	<20050913222830.GG7991@shell0.pdx.osdl.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wright <chrisw@osdl.org>
Date: Tue, 13 Sep 2005 15:28:30 -0700

> Might help to copy netdev on the report.  Seems you've had a bit of luck
> in reproducing.  Any chance on narrowing down to last known good kernel?
> There's been a fair bit of change in that driver between 2.6.12 and
> 2.6.13.

Michael Chan has already sent him a test patch for the tg3
driver to try and narrow this one down.  We think his chipset
is reordering MMIO's and the patch he's been sent tries to
confirm/deny that theory.

