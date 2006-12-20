Return-Path: <linux-kernel-owner+w=401wt.eu-S964856AbWLTDgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWLTDgs (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 22:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbWLTDgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 22:36:48 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:49995
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S964834AbWLTDgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 22:36:47 -0500
Date: Tue, 19 Dec 2006 19:36:46 -0800 (PST)
Message-Id: <20061219.193646.122617749.davem@davemloft.net>
To: bunk@stusta.de
Cc: chas@cmf.nrl.navy.mil, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/atm/fore200e.c: cleanups
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061219041258.GC6993@stusta.de>
References: <20061219041258.GC6993@stusta.de>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Tue, 19 Dec 2006 05:12:58 +0100

> This patch contains the following transformations from custom functions 
> to standard kernel version:
> - fore200e_kmalloc() -> kzalloc()
> - fore200e_kfree() -> kfree()
> - fore200e_swap() -> cpu_to_be32()
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Looks good, applied, thanks Adrian.
