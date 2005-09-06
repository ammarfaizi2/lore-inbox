Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbVIFPcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVIFPcR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 11:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbVIFPcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 11:32:17 -0400
Received: from main.gmane.org ([80.91.229.2]:37766 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750720AbVIFPcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 11:32:16 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: how to create atm interface in linux
Date: Tue, 06 Sep 2005 16:06:10 +0200
Message-ID: <pan.2005.09.06.14.06.10.837023@free.fr>
References: <20050906134335.48615.qmail@web8501.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Cc: linux-net@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, 06 Sep 2005 14:43:35 +0100, manomugdha biswas a écrit :

> Hi,
> I want to create an ATM interface on linux. I can
> create ethernet interface using alloc_etherdev() and
> then registering this device. Can I use the same
> function to create atm interface ? Or there is other
> way to do this? Can you please give some light on this
> issue?
> 
look how it is done in net/atm driver

Hint : use alloc_netdev

Matthieu

