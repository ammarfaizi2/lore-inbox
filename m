Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932682AbVLRJdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932682AbVLRJdi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 04:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbVLRJdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 04:33:38 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:39910
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932682AbVLRJdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 04:33:38 -0500
Date: Sun, 18 Dec 2005 01:33:41 -0800 (PST)
Message-Id: <20051218.013341.34772534.davem@davemloft.net>
To: akpm@osdl.org
Cc: rjwalsh@pathscale.com, rolandd@cisco.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 03/13] [RFC] ipath copy routines
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051217191932.af2b422c.akpm@osdl.org>
References: <20051217123833.1aa430ab.akpm@osdl.org>
	<1134859243.20575.84.camel@phosphene.durables.org>
	<20051217191932.af2b422c.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Sat, 17 Dec 2005 19:19:32 -0800

> That would make sense.  Give it a non-ipath-related name and require that
> all architectures which wish to run this driver must implement that
> (documented) function.
> 
> And, in Kconfig, make sure that architectures which don't implement that
> library function do not attempt to build this driver.  To avoid breaking
> `make allmodconfig'.

How about we implement a portable version in C that you get
by default if you don't implement the assembler routine?
Pretty please? :-)
