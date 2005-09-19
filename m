Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932715AbVISW0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbVISW0V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 18:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932714AbVISW0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 18:26:21 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:39092
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932713AbVISW0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 18:26:20 -0400
Date: Mon, 19 Sep 2005 15:26:28 -0700 (PDT)
Message-Id: <20050919.152628.125729992.davem@davemloft.net>
To: ecashin@coraid.com
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org, rolandd@cisco.com
Subject: Re: [patch 2.6.13] document alignment and byteorder macros
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <87ll1suali.fsf@coraid.com>
References: <87ll1suali.fsf@coraid.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed L Cashin <ecashin@coraid.com>
Date: Mon, 19 Sep 2005 15:22:01 -0400

> This patch comments the fact that although passing le64_to_cpup et
> al. is within the intended use of the byteorder macros, using
> get_unaligned is the recommended way to go.
> 
> Please speak up if there's a better place for this documentation to go
> or a better way to say it.
> 
> 
> document alignment and byteorder macros
> 
> Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

I think this is fine, I'll merge this in with my sparc64
fix when I send that upstream.

Please merge the AOE change to use get_unaligned() when
you get a chance.

Thanks a lot.
