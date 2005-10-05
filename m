Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbVJEIMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbVJEIMa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 04:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbVJEIMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 04:12:30 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:33449
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932568AbVJEIM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 04:12:29 -0400
Date: Wed, 05 Oct 2005 01:11:53 -0700 (PDT)
Message-Id: <20051005.011153.39539982.davem@davemloft.net>
To: viro@ftp.linux.org.uk
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix the breakage in sparc headers
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051005073601.GT7992@ftp.linux.org.uk>
References: <20051005073601.GT7992@ftp.linux.org.uk>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 5 Oct 2005 08:36:02 +0100

> 	If we switch extern inline to static inline, we'd better switch
> the pre-declarations we use to say that these puppies have __attribute_const__
> on them.  Otherwise we get extern declaration followed by static inline one.
> Which makes gcc unhappy, and for a good reason...
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: David S. Miller <davem@davemloft.net>

Linus, please apply.
