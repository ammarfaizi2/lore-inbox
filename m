Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265886AbTFVUdZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 16:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265897AbTFVUdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 16:33:25 -0400
Received: from p68.rivermarket.wintek.com ([208.13.56.68]:128 "EHLO
	dust.p68.rivermarket.wintek.com") by vger.kernel.org with ESMTP
	id S265886AbTFVUdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 16:33:24 -0400
Date: Sun, 22 Jun 2003 15:50:46 -0500 (EST)
From: Alex Goddard <agoddard@purdue.edu>
To: Pete Clements <clem@clem.clem-digital.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.73 fails complile (hotplug.c)
In-Reply-To: <200306222000.QAA12975@clem.clem-digital.net>
Message-ID: <Pine.LNX.4.56.0306221550280.11747@dust>
References: <200306222000.QAA12975@clem.clem-digital.net>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jun 2003, Pete Clements wrote:

> FYI:
> 
> drivers/pci/hotplug.c: In function `pci_remove_bus_device':
> drivers/pci/hotplug.c:262: warning: implicit declaration of function `pci_destroy_dev'
> drivers/pci/hotplug.c: At top level:
> drivers/pci/hotplug.c:224: warning: `pci_free_resources' defined but not used
> 
> ---
> 
> drivers/built-in.o: In function `pci_remove_bus_device':
> drivers/built-in.o(.text+0x2402): undefined reference to `pci_destroy_dev'
> make: *** [.tmp_vmlinux1] Error 1

Try turning CONFIG_HOTPLUG on.

-- 
Alex Goddard
agoddard@purdue.edu
