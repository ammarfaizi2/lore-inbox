Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319024AbSHSVN5>; Mon, 19 Aug 2002 17:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319023AbSHSVN5>; Mon, 19 Aug 2002 17:13:57 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:46046 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S319022AbSHSVN4>; Mon, 19 Aug 2002 17:13:56 -0400
Date: Mon, 19 Aug 2002 23:17:42 +0200
From: kladit@t-online.de (Klaus Dittrich)
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: 2.4.20-pre3 and promise raid contoller
Message-ID: <20020819211742.GA409@df1tlpc.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.4.20-pre3 the "Promise RAID controller" will be skipped.

The same occured with 2.4.19.rc2.

> On Thu, 18 Jul 2002, Bartlomiej Zolnierkiewicz wrote: 
> 
> > Just change '#ifdef' around 
> > if (dev->class >> 8 == PCI_CLASS_STORAGE_RAID) 
> > in ide-pci.c to '#ifndef' and it should work. 


Works with 2.4.20-pre3 too. 

-- 
Regads Klaus
