Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbTI3WuV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 18:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbTI3WtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 18:49:21 -0400
Received: from mail.kroah.org ([65.200.24.183]:39899 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261831AbTI3Wr0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 18:47:26 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1064961351233@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test6
In-Reply-To: <10649613503520@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Sep 2003 15:35:51 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1351, 2003/09/30 15:19:11-07:00, rtjohnso@eecs.berkeley.edu

[PATCH] PCI: __init documetation

It might not have prevented me from reporting the potential bug, but I
would've known you'd thought about it, it might help future developers,
and it's unlikely to become dangerously wrong.


 drivers/pci/quirks.c |    3 +++
 1 files changed, 3 insertions(+)


diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	Tue Sep 30 15:20:20 2003
+++ b/drivers/pci/quirks.c	Tue Sep 30 15:20:20 2003
@@ -750,6 +750,9 @@
 
 /*
  *  The main table of quirks.
+ *
+ *  Note: any hooks for hotpluggable devices in this table must _NOT_
+ *        be declared __init.
  */
 
 static struct pci_fixup pci_fixups[] __devinitdata = {

