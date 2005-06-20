Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVFTTW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVFTTW3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 15:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVFTTVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 15:21:44 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:16030 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261513AbVFTTRf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 15:17:35 -0400
Subject: Re: it8212 raid support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: admin@sumy.in.ua
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200506201914.16550.admin@sumy.in.ua>
References: <200506201914.16550.admin@sumy.in.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119294889.3325.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Jun 2005 20:14:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-06-20 at 17:14, Vladislav Bondarenko wrote:
> Where can i find support for it8212 raid pci card?
> It was in -ac patches, but after 2.6.11-ac7 it wasn`t support by Alan.
> 
> I make patch for this raid from -ac7 for 2.6.12, but when inclusion of a 
> it8212 raid support in the subsequent versions is expected? if this is 
> possible :)

There is a patch for 2.6.12-rc3 (should work on -rc5) in the current
Fedora kernel. Moving it all to 2.6.12 is a bit trickier because there
are big changes between -rc5 and -rc6 in the base IDE layer. (very
positive changes so although its a PITA for the -ac patches its good to
see)

