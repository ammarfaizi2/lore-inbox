Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbUAYHUa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 02:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbUAYHU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 02:20:29 -0500
Received: from pizda.ninka.net ([216.101.162.242]:57790 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263702AbUAYHU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 02:20:28 -0500
Date: Sat, 24 Jan 2004 23:11:37 -0800 (PST)
Message-Id: <20040124.231137.98548183.davem@redhat.com>
To: grundler@parisc-linux.org
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH] 2.6.1 tg3 DMA engine test failure
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20040125053101.GA19244@colo.lackof.org>
References: <20040125014859.GD16272@colo.lackof.org>
	<40132199.9090200@pobox.com>
	<20040125053101.GA19244@colo.lackof.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Grant Grundler <grundler@parisc-linux.org>
   Date: Sat, 24 Jan 2004 22:31:01 -0700

   email from "Wed Jan 21" says:
   "FTQ stands for Flow Through Queue and they are used to connect different
   state machines. It turns out that it should also be unnecessary to reset
   the FTQs as they get reset during GRC reset. While the FTQ reset itself
   is harmless, we recently discovered that it created a race condition
   with ASF firmware...."

A fix for this mentioned ASF race is in the current 2.4.x
and 2.6.x tg3 drivers.
