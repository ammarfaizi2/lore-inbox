Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbTFVHQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 03:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbTFVHQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 03:16:27 -0400
Received: from WebDev.iNES.RO ([80.86.100.174]:3468 "EHLO webdev.ines.ro")
	by vger.kernel.org with ESMTP id S262320AbTFVHQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 03:16:26 -0400
Date: Sun, 22 Jun 2003 10:30:29 +0300 (EEST)
From: Andrei Ivanov <andrei.ivanov@ines.ro>
X-X-Sender: shadow@webdev.ines.ro
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.72-mm3
In-Reply-To: <20030621224242.37ff8a7e.akpm@digeo.com>
Message-ID: <Pine.LNX.4.56L0.0306221029500.8220@webdev.ines.ro>
References: <20030621224242.37ff8a7e.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It doesn't compile:

  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x3183): In function `pci_remove_bus_device':
: undefined reference to `pci_destroy_dev'
make: *** [.tmp_vmlinux1] Error 1

