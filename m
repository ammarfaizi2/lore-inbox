Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262620AbVCJBKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbVCJBKp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbVCJBGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:06:38 -0500
Received: from mail.kroah.org ([69.55.234.183]:63903 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262640AbVCJAmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:38 -0500
Date: Wed, 9 Mar 2005 16:41:15 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] Add TPM driver support for 2.6.11
Message-ID: <20050310004115.GA32583@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a few changesets that add support for TPM drivers.  These
patches have all been in the -mm releases for a while now.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/2.6.11/tpm

Individual patches will follow, sent to the linux-kernel list.

thanks,

greg k-h

 drivers/char/Kconfig         |    2 
 drivers/char/Makefile        |    2 
 drivers/char/tpm/Kconfig     |   39 ++
 drivers/char/tpm/Makefile    |    7 
 drivers/char/tpm/tpm.c       |  715 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/char/tpm/tpm.h       |   92 +++++
 drivers/char/tpm/tpm_atmel.c |  218 +++++++++++++
 drivers/char/tpm/tpm_nsc.c   |  375 ++++++++++++++++++++++
 include/linux/pci_ids.h      |    1 
 9 files changed, 1439 insertions(+), 12 deletions(-)
-----


<kjhall:us.ibm.com>:
  o tpm: fix cause of SMP stack traces
  o Add TPM hardware enablement driver

Andrew Morton:
  o tpm-build-fix
  o tpm_atmel build fix
  o tpm_msc-build-fix

