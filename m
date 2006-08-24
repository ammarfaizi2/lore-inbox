Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWHXML1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWHXML1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 08:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWHXML1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 08:11:27 -0400
Received: from [81.2.110.250] ([81.2.110.250]:36004 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751179AbWHXML1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 08:11:27 -0400
Subject: RE: [RFC PATCH] prevent from killing OOM disabled task
	indo_page_fault()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Abu M. Muttalib" <abum@aftek.com>
Cc: Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <BKEKJNIHLJDCFGDBOHGMCENPDGAA.abum@aftek.com>
References: <BKEKJNIHLJDCFGDBOHGMCENPDGAA.abum@aftek.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Aug 2006 13:32:47 +0100
Message-Id: <1156422767.3007.111.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-24 am 17:14 +0530, ysgrifennodd Abu M. Muttalib:
> > No, its run tme configurable as is selection priority of the processes
> > which you want killed, has been for some time.
> 
> Will you please elaborate upon your reply.

See
	Documentation/sysctl/vm.txt
	Documenation/filesystems/proc.txt  (look for oom_adj)

in 2.6.18-rc

Alan
