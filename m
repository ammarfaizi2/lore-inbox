Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTFIKyW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 06:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbTFIKyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 06:54:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61074 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262827AbTFIKyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 06:54:21 -0400
Date: Mon, 09 Jun 2003 04:04:56 -0700 (PDT)
Message-Id: <20030609.040456.13756172.davem@redhat.com>
To: ink@jurassic.park.msu.ru
Cc: willy@debian.org, linux-kernel@vger.kernel.org, davidm@hpl.hp.com
Subject: Re: [PATCH] [3/3] PCI segment support
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030609150018.B15283@jurassic.park.msu.ru>
References: <20030609144242.A15283@jurassic.park.msu.ru>
	<20030609.034304.52179334.davem@redhat.com>
	<20030609150018.B15283@jurassic.park.msu.ru>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
   Date: Mon, 9 Jun 2003 15:00:18 +0400
   
   The root level controllers itself are not accessible from
   PCI config space (unlike x86 host bridges). They have
   dedicated control registers somewhere in the IO space.

This sounds more like a PCI host controller, not the
root of the actual PCI bus.
