Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWHXLWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWHXLWG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 07:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWHXLWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 07:22:05 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35267 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751126AbWHXLWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 07:22:03 -0400
Subject: RE: [RFC PATCH] prevent from killing OOM disabled task in
	do_page_fault()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Abu M. Muttalib" <abum@aftek.com>
Cc: Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <BKEKJNIHLJDCFGDBOHGMMENIDGAA.abum@aftek.com>
References: <BKEKJNIHLJDCFGDBOHGMMENIDGAA.abum@aftek.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Aug 2006 12:43:14 +0100
Message-Id: <1156419794.3007.99.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-24 am 15:43 +0530, ysgrifennodd Abu M. Muttalib:
> Hi,
> 
> > The process protected from oom-killer may be killed when do_page_fault()
> > runs out of memory. This patch skips those processes as well as init task.
> 
> Do we have any patch set to disable OOM all together for linux kernel
> 2.6.13?

No, its run tme configurable as is selection priority of the processes
which you want killed, has been for some time.

Alan

