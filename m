Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWHKVzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWHKVzN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 17:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWHKVzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 17:55:12 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:22914 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932425AbWHKVzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 17:55:10 -0400
Date: Sat, 12 Aug 2006 07:52:25 +1000
From: Anton Blanchard <anton@samba.org>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Cc: netdev <netdev@vger.kernel.org>, linux-ppc <linuxppc-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: Re: [PATCH 3/6] ehea: queue management
Message-ID: <20060811215225.GH479@krispykreme>
References: <44D99F38.8010306@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D99F38.8010306@de.ibm.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_ethtool.c	1969-12-31 

> +static void netdev_get_pauseparam(struct net_device *dev,
> +				  struct ethtool_pauseparam *pauseparam)
> +{
> +	printk("get pauseparam\n");
> +}

There are a number of stubbed out ethtool functions like this. Best not
to implement them and allow the upper layers to return a correct error.

Anton
