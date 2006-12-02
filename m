Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162764AbWLBEKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162764AbWLBEKW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 23:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162763AbWLBEKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 23:10:22 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:64729
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1162764AbWLBEKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 23:10:22 -0500
Date: Fri, 01 Dec 2006 20:10:28 -0800 (PST)
Message-Id: <20061201.201028.71163999.davem@davemloft.net>
To: kaber@trash.net
Cc: bunk@stusta.de, laforge@netfilter.org, netdev@vger.kernel.org,
       coreteam@netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [netfilter-core] [2.6 patch] remove ip{,6}_queue
From: David Miller <davem@davemloft.net>
In-Reply-To: <4570B912.6060105@trash.net>
References: <20061201205954.GH11084@stusta.de>
	<4570B912.6060105@trash.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick McHardy <kaber@trash.net>
Date: Sat, 02 Dec 2006 00:21:54 +0100

> We really can't remove ip_queue. Many users use this, there is no binary
> compatible interface and even the compat replacement for the originally
> statically linked library doesn't work. There is also no real necessity
> to remove the code, so the feature-removal-schedule entry should be
> removed instead.
> 
> Dave, please apply this patch. Thanks.

Done, thanks.
