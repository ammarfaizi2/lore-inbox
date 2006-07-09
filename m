Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030450AbWGILwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030450AbWGILwV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 07:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbWGILwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 07:52:21 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23005 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030450AbWGILwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 07:52:20 -0400
Subject: RE: Commenting out out_of_memory() function in __alloc_pages()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Abu M. Muttalib" <abum@aftek.com>
Cc: Robert Hancock <hancockr@shaw.ca>, chase.venters@clientec.com,
       kernelnewbies@nl.linux.org, linux-newbie@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
In-Reply-To: <BKEKJNIHLJDCFGDBOHGMAEFDDCAA.abum@aftek.com>
References: <BKEKJNIHLJDCFGDBOHGMAEFDDCAA.abum@aftek.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 09 Jul 2006 13:09:57 +0100
Message-Id: <1152446997.27368.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-07-09 am 17:18 +0530, ysgrifennodd Abu M. Muttalib:
> but I am running the application on an embedded device and have no swap..
> what do I need to do in this case??

Use less memory ?

You can play with /proc/sys/vm/overcommit_ratio. That is set at 50%
which is usually a good safe value with swap. If you know the kernel and
kernel memory will be 20% of memory worst case you can set it to 80 and
so on.

