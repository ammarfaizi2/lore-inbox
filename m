Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbUAZVKY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 16:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265193AbUAZVKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 16:10:24 -0500
Received: from pizda.ninka.net ([216.101.162.242]:53963 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264949AbUAZVKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 16:10:21 -0500
Date: Mon, 26 Jan 2004 12:57:13 -0800 (PST)
Message-Id: <20040126.125713.39171691.davem@redhat.com>
To: bunk@fs.tum.de
Cc: jt@bougret.hpl.hp.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-net@vger.kernel.org
Subject: Re: [patch] 2.6.2-rc2: link error with IrDA drivers
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20040126205829.GF513@fs.tum.de>
References: <Pine.LNX.4.58.0401251844440.32583@home.osdl.org>
	<20040126205829.GF513@fs.tum.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Adrian Bunk <bunk@fs.tum.de>
   Date: Mon, 26 Jan 2004 21:58:29 +0100

   This change causes the following compile error when trying to compile 
   an old plus a new version of one driver statically into the kernel:

That's not the right fix, just mark these init routines static.

I'll do that, thanks for the report.
