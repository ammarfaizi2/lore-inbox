Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161040AbWGJMxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbWGJMxL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 08:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161042AbWGJMxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 08:53:11 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50319 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161040AbWGJMxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 08:53:10 -0400
Subject: Re: [PATCH] Clean up old names in tty code to current names
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <9e4733910607100541i744dd744n16c35c50dae1e98d@mail.gmail.com>
References: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com>
	 <1152524657.27368.108.camel@localhost.localdomain>
	 <9e4733910607100541i744dd744n16c35c50dae1e98d@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Jul 2006 14:10:49 +0100
Message-Id: <1152537049.27368.119.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-10 am 08:41 -0400, ysgrifennodd Jon Smirl:
> The whole naming scheme encoded into the tty code is incompatible with
> udev. Udev allows renames and this code isn't aware of them.

The idea is not to break stuff. 

> It does seem that we are missing a user space library call for
> converting a device number into a device name using the udev database.

A very large number of users don't bother with udev. Relying on udev is
not a wise thing to assume, especially in the embedded space.

Alan

