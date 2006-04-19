Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWDSWZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWDSWZe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 18:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWDSWZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 18:25:33 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:34785
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751286AbWDSWZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 18:25:33 -0400
Date: Wed, 19 Apr 2006 15:25:34 -0700 (PDT)
Message-Id: <20060419.152534.02098739.davem@davemloft.net>
To: hzhong@gmail.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, torvalds@osdl.org,
       akpm@osdl.org
Subject: Re: [PATCH] sockfd_lookup_light() returns random error for -EBADFD
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <444688F2.5060909@gmail.com>
References: <444688F2.5060909@gmail.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hua Zhong <hzhong@gmail.com>
Date: Wed, 19 Apr 2006 12:01:06 -0700

> There is a missing initialization of err in sockfd_lookup_light() that could return random error for an invalid file handle.
> 
> Signed-off-by: Hua Zhong <hzhong@gmail.com>

Applied, thanks a lot for this bug fix.
