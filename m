Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbTDHUqv (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 16:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbTDHUqu (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 16:46:50 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:60467 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261674AbTDHUqu (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 16:46:50 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200304082057.h38KvJB16967@devserv.devel.redhat.com>
Subject: Re: 2.5.67-ac1: fix compile error in mtdblock.c
To: bunk@fs.tum.de (Adrian Bunk)
Date: Tue, 8 Apr 2003 16:57:19 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20030408200445.GM5046@fs.tum.de> from "Adrian Bunk" at Ebr 08, 2003 10:04:45 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> drivers/mtd/mtdblock.o drivers/mtd/mtdblock.c
> drivers/mtd/mtdblock.c: In function `mtd_notify_add':
> drivers/mtd/mtdblock.c:531: `name' undeclared (first use in this function)
> drivers/mtd/mtdblock.c:531: (Each undeclared identifier is reported only once
> drivers/mtd/mtdblock.c:531: for each function it appears in.)
> make[2]: *** [drivers/mtd/mtdblock.o] Error 1
> 
> <--  snip  -->
> 
> 
> Please _remove_ the following patch from -ac:

No 8) - but I will look a tmoving the name var somewhere to sort that out
