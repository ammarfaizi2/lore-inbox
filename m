Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161120AbWJNLvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161120AbWJNLvs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 07:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161121AbWJNLvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 07:51:48 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:6557 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161120AbWJNLvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 07:51:47 -0400
Subject: Re: [PATCH] drivers/char/riscom8.c: save_flags()/cli()/sti()
	removal
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Amol Lad <amol@verismonetworks.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>,
       kernel Janitors <kernel-janitors@lists.osdl.org>
In-Reply-To: <1160811574.19143.391.camel@amol.verismonetworks.com>
References: <1160739628.19143.376.camel@amol.verismonetworks.com>
	 <1160751657.25218.47.camel@localhost.localdomain>
	 <1160811574.19143.391.camel@amol.verismonetworks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 14 Oct 2006 13:18:12 +0100
Message-Id: <1160828292.5732.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-10-14 am 13:09 +0530, ysgrifennodd Amol Lad:
> On Fri, 2006-10-13 at 16:00 +0100, Alan Cox wrote:
> > Ar Gwe, 2006-10-13 am 17:10 +0530, ysgrifennodd Amol Lad:
> > > Removed save_flags()/cli()/sti() and used (light weight) spin locks
> > > 
> > 
> > Have you tested this and verified there are no recursive locking cases
> > in your changes ?
> 
> I doxygend riscom8.c and used call graphs to verify there are no
> recursive locks. I did a code review also

Thanks for the info. I'll give the code a second review (also not having
hardware) and then send you/Andrew either an Ack or corrections.

Alan

