Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271251AbRHOQFI>; Wed, 15 Aug 2001 12:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271253AbRHOQE5>; Wed, 15 Aug 2001 12:04:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43531 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271251AbRHOQEx>; Wed, 15 Aug 2001 12:04:53 -0400
Subject: Re: disk quota + 2.4.3 and higher -- OOPS
To: zakhar@silver.com.ua (Zakhar Kirpichenko)
Date: Wed, 15 Aug 2001 17:07:23 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10108151641270.10516-100000@rasta.silver.com.ua> from "Zakhar Kirpichenko" at Aug 15, 2001 04:50:25 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15X3CV-0003Rx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Sorry for offtopic (may be), but disk quotas don't work on Red Hat
> Linux 7.1 and kernels 2.2.x and 2.4.x. Quota tools installed from RPM
> package provided in standard RH distribution: quota-3.00-4, 2.4.2-2 kernel
> sources taken from the dist too. Other kernel versions support quota

Umm. I must be imagining the quotas that work on my test box.

The RH 7.1 quota tools assume you are running the updated quota code (needed
for 32bit user ids - the standard kernel tree code is just a dead loss in
the real world). Quota support is only available in some file systems too,
so MSDOS file systems for example do not support quota.

Alan
