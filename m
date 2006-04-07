Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbWDGU0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWDGU0S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 16:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWDGU0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 16:26:17 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:33975
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964888AbWDGU0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 16:26:17 -0400
Date: Fri, 07 Apr 2006 13:25:11 -0700 (PDT)
Message-Id: <20060407.132511.09521964.davem@davemloft.net>
To: vda@ilport.com.ua
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] deinline a few large functions in vlan code
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200604071628.30486.vda@ilport.com.ua>
References: <200604071628.30486.vda@ilport.com.ua>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Vlasenko <vda@ilport.com.ua>
Date: Fri, 7 Apr 2006 16:28:30 +0300

> What should be done with this?
> 1) Should I add respective select statements into Kconfigs
>    of those drivers?
> 2) Make vlan_dev non-modular?
> 3) Move functions to another .c file?

4) Leave it inline.

That's why we inline it in the first place.

