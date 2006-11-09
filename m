Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754362AbWKIHzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362AbWKIHzo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 02:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754365AbWKIHzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 02:55:43 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:21169
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1754362AbWKIHzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 02:55:42 -0500
Date: Wed, 08 Nov 2006 23:55:48 -0800 (PST)
Message-Id: <20061108.235548.12921799.davem@davemloft.net>
To: viro@ftp.linux.org.uk
Cc: kenneth.w.chen@intel.com, akpm@osdl.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [patch] fix up generic csum_ipv6_magic function prototype
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061109072216.GL29920@ftp.linux.org.uk>
References: <000301c703a3$0eedb340$ff0da8c0@amr.corp.intel.com>
	<20061108.230059.57444310.davem@davemloft.net>
	<20061109072216.GL29920@ftp.linux.org.uk>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 9 Nov 2006 07:22:16 +0000

> I haven't touch that argument yet; if there's an agreement as to what should
> we switch to, I'll do that.  So... does everyone agree that u32 is the way
> to go?

I definitely do.
