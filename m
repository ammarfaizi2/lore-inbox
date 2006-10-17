Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWJQVkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWJQVkh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWJQVkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:40:37 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:26779
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750767AbWJQVkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:40:36 -0400
Date: Tue, 17 Oct 2006 14:40:41 -0700 (PDT)
Message-Id: <20061017.144041.58455372.davem@davemloft.net>
To: jengelh@linux01.gwdg.de
Cc: andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: Sparc64 kernel message: BUG: soft lockup detected on CPU#3!
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0610170843150.17410@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0610170053280.30479@yvahk01.tjqt.qr>
	<20061016.174100.48529083.davem@davemloft.net>
	<Pine.LNX.4.61.0610170843150.17410@yvahk01.tjqt.qr>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Tue, 17 Oct 2006 18:53:48 +0200 (MEST)

> ttya... backside. ttyb... backside. RSC... backside in a PCI slot, that 
> makes three. Where is the 4th?

Each SAB chip provides two ports at a time, therefore I guess the 4th
is wired down to NULL but it is there.
