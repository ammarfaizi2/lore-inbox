Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVC0QnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVC0QnF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 11:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVC0QnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 11:43:05 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:20637 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261412AbVC0QnC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 11:43:02 -0500
Subject: Re: [2.6 patch] drivers/net/wan/: possible cleanups
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050327143418.GE4285@stusta.de>
References: <20050327143418.GE4285@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1111941516.14877.325.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 27 Mar 2005 17:38:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-03-27 at 15:34, Adrian Bunk wrote:
>   - syncppp.c: sppp_input
>   - syncppp.c: sppp_change_mtu
>   - z85230.c: z8530_dma_sync
>   - z85230.c: z8530_txdma_sync

Please leave the z85230 ones at least. They are an intentional part of
the external API for writing other 85230 card drivers.

Alan

