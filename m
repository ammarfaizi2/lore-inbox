Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbVJZUyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbVJZUyi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 16:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbVJZUyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 16:54:38 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:57803 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S964916AbVJZUyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 16:54:38 -0400
X-Mailbox-Line: From laurent@antares.localdomain mer oct 26 22:49:09 2005
Message-Id: <20051026204802.123045000@antares.localdomain>
Date: Wed, 26 Oct 2005 22:48:02 +0200
From: Laurent riffard <laurent.riffard@free.fr>
To: linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>,
       Greg KH <greg@kroah.com>, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [RFC patch 0/3] remove pci_driver.owner and .name fields
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm willing to submit patches to remove pci_driver.owner and .name
fields. pci_driver.driver.owner and .name will be used instead.

Patch 1 prepares the core pci code for future removal of the 2
fields, but actually do not remove them. As suggested by Al Viro,
pci_driver.driver.owner will be set by pci_register_driver.

Patch 2 is an example of driver's update. There will be lots of
patches like this.

Patch 3 is the final touch, after all pci_driver.name and
pci_driver.owner are removed.

Any comments ? Feel free to correct my bad english.

thanks
--
laurent


