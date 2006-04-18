Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWDRVu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWDRVu0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 17:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWDRVu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 17:50:26 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:61110
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750703AbWDRVu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 17:50:26 -0400
Date: Tue, 18 Apr 2006 14:50:22 -0700 (PDT)
Message-Id: <20060418.145022.80874721.davem@davemloft.net>
To: dev@openvz.org
Cc: akpm@osdl.org, devel@openvz.org, linux-kernel@vger.kernel.org,
       dim@openvz.org
Subject: Re: [PATCH] unaligned access in sk_run_filter()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <4443780B.1040108@openvz.org>
References: <4443780B.1040108@openvz.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill Korotaev <dev@openvz.org>
Date: Mon, 17 Apr 2006 15:12:11 +0400

> [PATCH] unaligned access in sk_run_filter()
> 
> This patch fixes unaligned access warnings noticed on IA64
> in sk_run_filter(). 'ptr' can be unaligned.
> 
> Signed-Off-By: Dmitry Mishin <dim@openvz.org>
> Signed-Off-By: Kirill Korotaev <dev@openvz.org>

I've been meaning to add this fix, thanks a lot.
