Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269091AbUIBWYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269091AbUIBWYa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269146AbUIBWY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:24:26 -0400
Received: from smtp110.mail.sc5.yahoo.com ([66.163.170.8]:6840 "HELO
	smtp110.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269091AbUIBWXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:23:14 -0400
Date: Thu, 2 Sep 2004 15:22:14 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Per von Zweigbergk <pvz@e.kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_BSD_DISKLABEL not in 2.6.8.1?
Message-Id: <20040902152214.2b3d5cb9.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.44.0409030003200.1068-100000@quetzalcoatlite.e.kth.se>
References: <Pine.LNX.4.44.0409030003200.1068-100000@quetzalcoatlite.e.kth.se>
Organization: DaveM Loft Enterprises
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2004 00:03:42 +0200 (CEST)
Per von Zweigbergk <pvz@e.kth.se> wrote:

> Older kernel versions had a CONFIG_BSD_DISKLABEL option, which was 
> configurable via menuconfig etcetera, but 2.6.8.1 doesn't seem to have it 
> in menuconfig.

Enable CONDIG_PARTITION_ADVANCED and CONFIG_MSDOS_PARTITION,
this will enable selection of CONFIG_BSD_DISKLABEL.
