Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263247AbSJIAyH>; Tue, 8 Oct 2002 20:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSJIAw5>; Tue, 8 Oct 2002 20:52:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56489 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263228AbSJIAwi>;
	Tue, 8 Oct 2002 20:52:38 -0400
Date: Tue, 08 Oct 2002 17:51:16 -0700 (PDT)
Message-Id: <20021008.175116.22950725.davem@redhat.com>
To: bcrl@redhat.com
Cc: neilb@cse.unsw.edu.au, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] silence an unnescessary raid5 debugging message
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021008193612.H15858@redhat.com>
References: <20021008180350.A15858@redhat.com>
	<15779.27330.284336.914423@notabene.cse.unsw.edu.au>
	<20021008193612.H15858@redhat.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Benjamin LaHaise <bcrl@redhat.com>
   Date: Tue, 8 Oct 2002 19:36:12 -0400
   
   As it stands, the syslogging from the printk does more damage to
   performance than the underlying problem.  Besides, LVM snapshots
   are slow, but they're useful for a class of problems anyways.

He's just saying kill the real problem first, that's all.
