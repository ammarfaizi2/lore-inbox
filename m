Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbVG2Tli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbVG2Tli (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbVG2TjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:39:09 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:29130
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262775AbVG2TiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:38:05 -0400
Date: Fri, 29 Jul 2005 12:37:44 -0700 (PDT)
Message-Id: <20050729.123744.41648141.davem@davemloft.net>
To: vda@ilport.com.ua
Cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       coreteam@netfilter.org, laforge@netfilter.org, jmorris@redhat.com
Subject: Re: iptables redirect is broken on bridged setup
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200507291209.37247.vda@ilport.com.ua>
References: <200507291209.37247.vda@ilport.com.ua>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Vlasenko <vda@ilport.com.ua>
Date: Fri, 29 Jul 2005 12:11:52 +0300

> Linux 2.6.12
> 
> Was running for months with this simple iptables rule:
 ...
> But now I need to bridge together two eth cards in this machine, and
> suddenly redirect is no longer works.

I think this is the regression we fixed up in 2.6.12.x, can
you try the latest 2.6.12.x stable release and see if it
clears up this behavioral change?
