Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269172AbUI2WSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269172AbUI2WSk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 18:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269203AbUI2WRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 18:17:47 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:25483 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269172AbUI2WOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 18:14:31 -0400
Subject: Re: [PATCH 2.6.9-rc2-mm4 alim15x3.c] [3/8] Replace pci_find_device
	with pci_dev_present
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hanna Linder <hannal@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitors@lists.osdl.org, greg@kroah.com,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <13230000.1096487909@w-hlinder.beaverton.ibm.com>
References: <13230000.1096487909@w-hlinder.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096492303.16767.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 29 Sep 2004 22:11:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-29 at 20:58, Hanna Linder wrote:
> The dev returned from pci_find_device was not used so it can be replaced
> with pci_dev_present. Has been compile tested.

Maybe that test should just go. Its been getting tested since 2.4.20 or
so 8)

