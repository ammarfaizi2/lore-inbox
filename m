Return-Path: <linux-kernel-owner+w=401wt.eu-S964834AbXAJK5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbXAJK5s (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 05:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbXAJK5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 05:57:48 -0500
Received: from stinky.trash.net ([213.144.137.162]:64695 "EHLO
	stinky.trash.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964834AbXAJK5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 05:57:47 -0500
Message-ID: <45A4C6A8.10401@trash.net>
Date: Wed, 10 Jan 2007 11:57:44 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Starvik <mikael.starvik@axis.com>
CC: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       Edgar Iglesias <edgar.iglesias@axis.com>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: Iptable loop during kernel startup
References: <BFECAF9E178F144FAEF2BF4CE739C668030B5903@exmail1.se.axis.com>
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C668030B5903@exmail1.se.axis.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Starvik wrote:
> I have a kernel with
> 
> CONFIG_IP_NF_TABLES=y
> CONFIG_IP_NF_FILTER=y
> CONFIG_IP_NF_TARGET_LOG=y
> 
> all other NF options are off.

Which iptables/kernel versions are you using?

> During kernel startup I get
> iptables: loop hook 1 pos 00000022
> 
> when filter tries to register at module_init.
> 
> Any ideas why I get this loop?

Please post your ruleset and the kernel config.
