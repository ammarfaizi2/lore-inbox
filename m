Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946647AbWKAGX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946647AbWKAGX3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 01:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946649AbWKAGX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 01:23:29 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:38092
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1946647AbWKAGX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 01:23:28 -0500
Date: Tue, 31 Oct 2006 22:23:30 -0800 (PST)
Message-Id: <20061031.222330.28789606.davem@davemloft.net>
To: w@1wt.eu
Cc: chrisw@sous-sol.org, linux-kernel@vger.kernel.org,
       herbert@gondor.apana.org.au
Subject: Re: [PATCH 40/61] SCTP: Always linearise packet on input
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061101071722.GC543@1wt.eu>
References: <20061101053340.305569000@sous-sol.org>
	<20061101054231.472027000@sous-sol.org>
	<20061101071722.GC543@1wt.eu>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <w@1wt.eu>
Date: Wed, 1 Nov 2006 08:17:22 +0100

> This one seems to be valid for 2.4 too. Should I merge it or is it
> unneeded ?

Indeed it appears that the problem can be triggered via IP
fragmentation on input even in 2.4.x, so yes it would be good
to put the fix there too.

Thanks for noticing this Willy.
