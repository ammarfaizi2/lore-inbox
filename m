Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264202AbTEaIBG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 04:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264204AbTEaIBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 04:01:05 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4278 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264202AbTEaIBF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 04:01:05 -0400
Date: Sat, 31 May 2003 01:12:51 -0700 (PDT)
Message-Id: <20030531.011251.02293594.davem@redhat.com>
To: joern@wohnheim.fh-wedel.de
Cc: jmorris@intercode.com.au, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: [PATCH RFC] 1/2 central workspace for zlib
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030531081129.GA26179@wohnheim.fh-wedel.de>
References: <20030531075615.GA25089@wohnheim.fh-wedel.de>
	<20030531.005909.68051039.davem@redhat.com>
	<20030531081129.GA26179@wohnheim.fh-wedel.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jörn Engel <joern@wohnheim.fh-wedel.de>
   Date: Sat, 31 May 2003 10:11:29 +0200
   
   In softirq context you would be right.  Preempt is disabled anyway
   and cpu affinity comes for free.

Looks ok to me then.
