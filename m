Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269165AbUI2XSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269165AbUI2XSz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 19:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269168AbUI2XSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 19:18:21 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:33163 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269166AbUI2XSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 19:18:16 -0400
Subject: Re: [PATCH 2.6.9-rc2-mm4 zr36120.c][5/8] Convert pci_find_device
	to pci_dev_present
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hanna Linder <hannal@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitors@lists.osdl.org, greg@kroah.com, kraxel@bytesex.org
In-Reply-To: <19730000.1096496900@w-hlinder.beaverton.ibm.com>
References: <19730000.1096496900@w-hlinder.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096496127.16721.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 29 Sep 2004 23:15:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-29 at 23:28, Hanna Linder wrote:
> The dev was not used from pci_find_device so it was acceptable to replace
> with pci_dev_present. There was no need for it to be in a while loop originally.
> Compile tested.

That code should die I think. All the tests it does are done in
pci/quirks.c and set up pci_pci_flags

