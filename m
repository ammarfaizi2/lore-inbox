Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030404AbWGTXOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030404AbWGTXOg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 19:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030402AbWGTXOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 19:14:36 -0400
Received: from mail.smartlink.ee ([213.180.16.242]:1751 "EHLO
	mail.smartlink.ee") by vger.kernel.org with ESMTP id S1030404AbWGTXOg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 19:14:36 -0400
Message-ID: <44C00E59.5050806@smartlink.ee>
Date: Fri, 21 Jul 2006 02:14:33 +0300
From: Kalev Lember <kalev@smartlink.ee>
User-Agent: Thunderbird 1.5.0.4 (X11/20060610)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Antti Andreimann <anttix@smartlink.ee>
Subject: IPSEC key sync
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

OpenBSD has sasyncd daemon to synchronize IPSEC keys between two or more
hosts that should act as failover gateways. I am wondering if it is
possible to do this with Linux.

There are IP_VS_PROTO_ESP and IP_VS_PROTO_AH configuration options which
claim to do "ESP and AH load balancing support". I am wondering what
does this exactly mean? I tried IPVS compiled with those options with
keepalived and it didn't seem to synchronize keys.

Maybe sasyncd should be ported to Linux?

-- 
Kalev Lember
