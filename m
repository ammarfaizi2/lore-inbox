Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWFZOV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWFZOV1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 10:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbWFZOV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 10:21:27 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:12958 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1751234AbWFZOV0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 10:21:26 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200606261415.k5QEFN0J013431@wildsau.enemy.org>
Subject: Re: finding pci_dev from scsi_device
In-Reply-To: <1151331181.3185.44.camel@laptopd505.fenrus.org>
To: Arjan van de Ven <arjan@infradead.org>
Date: Mon, 26 Jun 2006 16:15:23 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Could someone please tell me how to find the corresponding
> > "struct pci_dev *" from a given "struct scsi_device *"?
> > 
> > I've been searching through structures/header files now for
> > quite some time, but cannot find anything.
> 
> looking at my isa bus scsi controller... I'd say that that is a really
> hard question that doesn't even always have an answer ;)

umh, yes, but in this case, I'm sure I always have a pci_dev.
 
> can you share with us what you want to do with this?

I need the pci_dev to reconfigure ahci-controllers so that they look like
having been initialised by BIOS at reboot time.

kind regards,
h.rosmanith 
