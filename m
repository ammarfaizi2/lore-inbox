Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTEOBiC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 21:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263506AbTEOBiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 21:38:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:12704 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263444AbTEOBiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 21:38:01 -0400
Date: Wed, 14 May 2003 18:49:09 -0700 (PDT)
Message-Id: <20030514.184909.10310254.davem@redhat.com>
To: akpm@digeo.com
Cc: alan@lxorguk.ukuu.org.uk, bunk@fs.tum.de, hch@infradead.org,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       fventuri@mediaone.net
Subject: Re: 2.5.69-mm5: sb1000.c: undefined reference to `alloc_netdev'
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030514124106.5a13c199.akpm@digeo.com>
References: <20030514103115.465d18a8.akpm@digeo.com>
	<1052936763.2492.57.camel@dhcp22.swansea.linux.org.uk>
	<20030514124106.5a13c199.akpm@digeo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Wed, 14 May 2003 12:41:06 -0700

   Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
   > Its far from bogus. Its an rx only cable modem device. Your uplink is
   > modem and you dont want to arp on it
   
   diff -puN drivers/net/sb1000.c~sb1000-fix drivers/net/sb1000.c
   --- 25/drivers/net/sb1000.c~sb1000-fix	Wed May 14 12:39:10 2003
   +++ 25-akpm/drivers/net/sb1000.c	Wed May 14 12:40:20 2003

Applied, thanks Andrew.
