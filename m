Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbVHRVcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbVHRVcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 17:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVHRVck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 17:32:40 -0400
Received: from dsl027-180-204.sfo1.dsl.speakeasy.net ([216.27.180.204]:46241
	"EHLO outer-richmond.davemloft.net") by vger.kernel.org with ESMTP
	id S932466AbVHRVck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 17:32:40 -0400
Date: Thu, 18 Aug 2005 14:32:24 -0700 (PDT)
Message-Id: <20050818.143224.111875937.davem@davemloft.net>
To: aaw@rincewind.tv
Cc: kaber@trash.net, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix dst_entry leak in icmp_push_reply()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <4304DBFB.5010906@rincewind.tv>
References: <4304D763.4090001@rincewind.tv>
	<4304DA99.2080205@trash.net>
	<4304DBFB.5010906@rincewind.tv>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ollie Wild <aaw@rincewind.tv>
Date: Thu, 18 Aug 2005 12:05:31 -0700

> Patrick McHardy wrote:
> 
> >Checking the return value of ip_append_data seems cleaner to me.
> >Patch attached.
> >  
> >
> Works for me.

Applied, thanks everyone.
