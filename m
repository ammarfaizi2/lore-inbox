Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVBPWxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVBPWxO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 17:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbVBPWxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 17:53:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:54152 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262111AbVBPWwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 17:52:44 -0500
Date: Wed, 16 Feb 2005 14:51:26 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.6.11-rc4
Message-ID: <20050216225126.GA13976@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a three USB bugfixes for 2.6.11-rc4.  All of them have been
promised to fix problems and not cause new ones :)

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/fix-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 
 drivers/usb/core/hub.c      |    3 +++
 drivers/usb/host/ehci-hcd.c |   25 +++++++++++++++++++++++--
 drivers/usb/host/ehci-q.c   |    3 ++-
 3 files changed, 28 insertions(+), 3 deletions(-)
-----


Alan Stern:
  o USB Hub driver: Add reset recovery-time delay

Brian Murphy:
  o USB: ehci requeue revisit

David Brownell:
  o USB: ehci patch for NF4 port miscounting

