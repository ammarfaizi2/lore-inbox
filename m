Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVAIB7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVAIB7M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 20:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVAIB7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 20:59:12 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:13510 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262187AbVAIB7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 20:59:09 -0500
Subject: ERROR: [PATCH] moxa: Update status of Moxa Smartio driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: torvalds@osdl.org, james4765@gmail.com
In-Reply-To: <200501082329.j08NT873032639@hera.kernel.org>
References: <200501082329.j08NT873032639@hera.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105232081.12028.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 09 Jan 2005 00:54:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This changeset is incorrect. The "1.8" version is for the Moxa mxser
driver. Moxa haven't released any 2.6 driver for the ancient "smartio"
hardware. (Checked this while fixing mxser).

In the mxser case that change and update has now been done.

Please revert this changeset.

Alan (with tty layer hat on)


> ChangeSet 1.2371, 2005/01/08 14:09:24-08:00, james4765@gmail.com

> +***NOTE*** - The driver included in the kernel is not maintained by Moxa.  They
> +have a version 1.8 driver available from:
> +
> +http://www.moxa.com
> +
> +that works with 2.6 kernels.  Currently, Moxa has no plans to have their updated
> +driver merged into the kernel.
> +
> +James Nelson <james4765@gmail.com> - 12-12-2004
> +


