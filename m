Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161050AbWGISn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbWGISn5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 14:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161046AbWGISn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 14:43:57 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:56974
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161037AbWGISn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 14:43:56 -0400
Date: Sun, 09 Jul 2006 11:44:29 -0700 (PDT)
Message-Id: <20060709.114429.109081601.davem@davemloft.net>
To: mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: 2.6.18-rc1 fails to boot on Ultra 5
From: David Miller <davem@davemloft.net>
In-Reply-To: <200607091040.k69AewNu019891@harpo.it.uu.se>
References: <200607091040.k69AewNu019891@harpo.it.uu.se>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Sun, 9 Jul 2006 12:40:58 +0200 (MEST)

> 2.6.17-git7 was the last development kernel to boot on my U5.
> 2.6.17-git8 to -git15 all hang immediately after being loaded.
> 2.6.17-git16 to 2.6.18-rc1 partially boot but crash and burn in
> different places depending on kernel configuration: my standard
> config got alignment exceptions in the floppy driver followed by
> (sabre?) PCI errors and a hang; a minimal kernel gets further but
> fails "su" probe and then oopses hard when the /dev/hda partition
> table is about to be printed.
> 
> I'll try to capture the kernel messages soon, but I don't have
> a null-modem serial cable to the U5 yet, and my attempts to use
> a digital camera only resulted in blurry pictures of the screen :-(

I have an ultra5 here, I'll give it some testing.  I bet I messed up
the interrupt mapping register handling for the Sabre pci controller.

Thanks for the report.
