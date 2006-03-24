Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422733AbWCXARl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422733AbWCXARl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 19:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422926AbWCXARk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 19:17:40 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:12944
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1422923AbWCXARj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 19:17:39 -0500
Date: Thu, 23 Mar 2006 16:13:14 -0800 (PST)
Message-Id: <20060323.161314.59991770.davem@davemloft.net>
To: bunk@stusta.de
Cc: zhaojignmin@hotmail.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: [2.6 patch] ip_conntrack_helper_h323.c: EXPORT_SYMBOL'ed
 functions shouldn't be static
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060324000801.GM22727@stusta.de>
References: <20060324000801.GM22727@stusta.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Fri, 24 Mar 2006 01:08:01 +0100

> EXPORT_SYMBOL'ed functions shouldn't be static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Fixed in Linus's tree as of yesterday.

I actually have a patch from Patrick McHardy that will make
this kind of error a build time failure instead of silently
working in the modular case.  I just need to test it out
a bit before pushing.

