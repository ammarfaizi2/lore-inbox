Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbVHJE36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbVHJE36 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 00:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbVHJE36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 00:29:58 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:35999
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964946AbVHJE35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 00:29:57 -0400
Date: Tue, 09 Aug 2005 21:29:44 -0700 (PDT)
Message-Id: <20050809.212944.29572759.davem@davemloft.net>
To: kaber@trash.net
Cc: shd@modeemi.cs.tut.fi, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/ipv4 debug cleanup, kernel 2.6.13-rc5
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <42F953CE.305@trash.net>
References: <20050807123145.GJ27323@jolt.modeemi.cs.tut.fi>
	<42F953CE.305@trash.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick McHardy <kaber@trash.net>
Date: Wed, 10 Aug 2005 03:09:34 +0200

> These macros always looked a bit ugly to me, with your cleanup there
> isn't a single spot left where we require them to accept code as
> argument, so how about we change them to pure printk wrappers?

Applied to 2.6.14, with two changes:

1) the dccp cases fixed up
2) the args for the #if 0 part of sock.h fixed up
