Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030409AbWGTXUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030409AbWGTXUE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 19:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWGTXUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 19:20:04 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:37255
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030409AbWGTXUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 19:20:03 -0400
Date: Thu, 20 Jul 2006 16:20:05 -0700 (PDT)
Message-Id: <20060720.162005.107940612.davem@davemloft.net>
To: kalev@smartlink.ee
Cc: linux-kernel@vger.kernel.org, anttix@smartlink.ee
Subject: Re: IPSEC key sync
From: David Miller <davem@davemloft.net>
In-Reply-To: <44C00E59.5050806@smartlink.ee>
References: <44C00E59.5050806@smartlink.ee>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kalev Lember <kalev@smartlink.ee>
Date: Fri, 21 Jul 2006 02:14:33 +0300

> There are IP_VS_PROTO_ESP and IP_VS_PROTO_AH configuration options which
> claim to do "ESP and AH load balancing support". I am wondering what
> does this exactly mean? I tried IPVS compiled with those options with
> keepalived and it didn't seem to synchronize keys.

It does exactly what it claims, it load balances traffic
using the ESP/AH SPI field as part of the load balancing
hashing algorithm.

It does nothing more, nothing less.

