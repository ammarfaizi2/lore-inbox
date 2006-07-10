Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWGJJ0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWGJJ0h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWGJJ0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:26:37 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:6303 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932417AbWGJJ0g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:26:36 -0400
Subject: Re: [PATCH] Clean up old names in tty code to current names
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com>
References: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Jul 2006 10:44:17 +0100
Message-Id: <1152524657.27368.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-10 am 00:11 -0400, ysgrifennodd Jon Smirl:
> Fix various places in the tty code to make it match the current naming system.
>         pty_slave_driver->driver_name = "pty_slave";


NAK to just about all of this. Its gratuitous breaking of existing apps,
it achieves nothing and some of it like the pty stuff is just plain
incorrect anyway.

If you want to add sysfs interfaces to the tty code great, but please
leave the existing, relied up, functional and effectively user space ABI
tty files alone.

Alan

