Return-Path: <linux-kernel-owner+w=401wt.eu-S1751840AbWLNAXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbWLNAXY (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 19:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751843AbWLNAXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 19:23:24 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:55327
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751840AbWLNAXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 19:23:23 -0500
Date: Wed, 13 Dec 2006 16:23:22 -0800 (PST)
Message-Id: <20061213.162322.28789366.davem@davemloft.net>
To: shemminger@osdl.org
Cc: bunk@stusta.de, tgraf@suug.ch, viro@ftp.linux.org.uk, jgarzik@pobox.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/loopback.c: convert to module_init()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061213154125.5e118ba5@dxpl.pdx.osdl.net>
References: <20061213231848.GY8693@postel.suug.ch>
	<20061213233128.GD3629@stusta.de>
	<20061213154125.5e118ba5@dxpl.pdx.osdl.net>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Wed, 13 Dec 2006 15:41:25 -0800

> But what if other network device is not a module. We want loopback
> to be first. so it needs to be before other device_initcall's

That's not happening today, so it's "broken" today, which suggests
that the order in all likelyhood no longer matters.
