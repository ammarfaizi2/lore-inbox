Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269619AbTGZUpq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 16:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269646AbTGZUpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 16:45:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:61416 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269619AbTGZUpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 16:45:31 -0400
Date: Sat, 26 Jul 2003 14:05:03 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@ucw.cz>
cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp updates
In-Reply-To: <20030726204528.GA350@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0307261403390.23977-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This updates swsusp: CONFIG_SOFTWARE_SUSPEND and CONFIG_ACPI_SLEEP are
> separated (it was getting users *badly* confused), remove too noisy
> printk's, correctly restore console after S3, fixes suspend on
> machines using yenta_socket.c, fixes some comments, cleans up
> "interesting" macro mess in suspend.c, no longer eats filesystems when
> process is ^Z-ed before suspend. Please apply,

Could you please split these patches up into different functional patches, 
and submit them to the appropriate maintainers? 


	-pat


