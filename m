Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030456AbWGILhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030456AbWGILhr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 07:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbWGILhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 07:37:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56199 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030452AbWGILhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 07:37:46 -0400
Subject: RE: Commenting out out_of_memory() function in __alloc_pages()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Abu M. Muttalib" <abum@aftek.com>
Cc: Robert Hancock <hancockr@shaw.ca>, chase.venters@clientec.com,
       kernelnewbies@nl.linux.org, linux-newbie@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
In-Reply-To: <BKEKJNIHLJDCFGDBOHGMCEEGDCAA.abum@aftek.com>
References: <BKEKJNIHLJDCFGDBOHGMCEEGDCAA.abum@aftek.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 09 Jul 2006 12:55:07 +0100
Message-Id: <1152446107.27368.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-07-09 am 09:53 +0530, ysgrifennodd Abu M. Muttalib:
> Hi,
> 
> I tried with the /proc/sys/vm/overcommit_memory=2 and the system refused to
> load the program altogether.
> 
> In this scenario is making overcommit_memory=2 a good idea?

It will refuse to load the program if that would use enough memory that
the system cannot be sure it will not run out of memory having done so.
You probably need a lot more swap.

