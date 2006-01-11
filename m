Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWAKFDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWAKFDL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 00:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWAKFDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 00:03:11 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:8608
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751370AbWAKFDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 00:03:10 -0500
Date: Tue, 10 Jan 2006 21:03:02 -0800 (PST)
Message-Id: <20060110.210302.05040649.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: jgarzik@pobox.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix wireless build
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1136949452.5333.4.camel@localhost.localdomain>
References: <1136949452.5333.4.camel@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 11 Jan 2006 14:17:32 +1100

> Current wireless core doesn't link here with a link error on
> compare_ether_addr. The function exists, but is defined inline and the
> wireless code forgets to #include the file containing the definition.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Sorry about that.  Linus fixed it in his tree already, thanks
for the report.
