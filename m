Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbTFVHXj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 03:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263782AbTFVHXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 03:23:38 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:30715 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262382AbTFVHXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 03:23:38 -0400
Date: Sun, 22 Jun 2003 00:38:03 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andrei Ivanov <andrei.ivanov@ines.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.72-mm3
Message-Id: <20030622003803.3366a3f5.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.56L0.0306221029500.8220@webdev.ines.ro>
References: <20030621224242.37ff8a7e.akpm@digeo.com>
	<Pine.LNX.4.56L0.0306221029500.8220@webdev.ines.ro>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jun 2003 07:37:42.0383 (UTC) FILETIME=[2A1357F0:01C33891]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrei Ivanov <andrei.ivanov@ines.ro> wrote:
>
> 
> It doesn't compile:
> 
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0x3183): In function `pci_remove_bus_device':
> : undefined reference to `pci_destroy_dev'
> make: *** [.tmp_vmlinux1] Error 1
> 

You can work around that by setting CONFIG_HOTPLUG=y
