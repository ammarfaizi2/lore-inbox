Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271048AbUJUWvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271048AbUJUWvP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271020AbUJUWsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:48:25 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:5086 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S271052AbUJUWif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:38:35 -0400
Subject: Re: [PATCH 2.4.28-pre4-bk6] delkin_cb: new driver for Cardbus IDE
	CF adaptor
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Lord <lkml@rtr.ca>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4178232B.5000506@rtr.ca>
References: <41780393.3000606@rtr.ca>
	 <58cb370e041021121317083a3a@mail.gmail.com> <41781B13.3030803@rtr.ca>
	 <58cb370e041021134269c05f17@mail.gmail.com>  <4178232B.5000506@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098394554.17857.177.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Oct 2004 22:35:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-10-21 at 21:59, Mark Lord wrote:
> That kernel breaks suspend/resume on my notebooks,
> and is a dog for disk performance.  Still, I'd happily
> port this new driver to it if there was a hope in hell
> that the effort wouldn't be a total waste of my time.

If you can drop it into the 2.6-ac patches that would be great and
I will merge it from review of the current code. That should have
correct IDE locking and also possibly correct PCI IDE locking (actually
I need to fix one detail).

Having a cardbus IDE adapter would be a godsend for my testing so I'll
see if I can find a source of them over here too for brutalising the
code.

The only visible difference is that we pass a hwif to the unregister
functions in the -ac tree.

Alan

