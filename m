Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbVJNG7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbVJNG7T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 02:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbVJNG7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 02:59:19 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48559
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750863AbVJNG7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 02:59:18 -0400
Date: Thu, 13 Oct 2005 23:59:07 -0700 (PDT)
Message-Id: <20051013.235907.66789139.davem@davemloft.net>
To: frank@tuxrocks.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Kconfig Dependencies for CONFIG_NET_CLS_RSVP6
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <434F5247.2040007@tuxrocks.com>
References: <434F5247.2040007@tuxrocks.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Sorenson <frank@tuxrocks.com>
Date: Fri, 14 Oct 2005 00:37:59 -0600

> I noticed that I can still select "Special RSVP classifier for IPv6"
> even if "The IPv6 protocol" isn't selected.  Should CONFIG_NET_CLS_RSVP6
> depend on or select IPV6?
> 
> Currently:
> Depends on: NET && NET_CLS && NET_QOS

It doesn't need the ipv6 stack at all, it's just a classifier
that looks at packet headers and makes decisions.
