Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265501AbTFMTjd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 15:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265503AbTFMTjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 15:39:33 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:3505 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265501AbTFMTjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 15:39:11 -0400
Date: Fri, 13 Jun 2003 12:52:14 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, Kurt.Robideau@comtrol.com
Subject: [BK PATCH] Rocketport changes for 2.5.70-bk
Message-ID: <20030613195214.GA1260@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a changeset for the rocketport driver against the latest 2.5.70 bk tree.
It does the following:
	-  Removed non-GPL license text from headers
	-  Removed check_region()/request_region() raciness
	-  Made the driver a >2.5 driver only
  
Please pull from:
        bk://kernel.bkbits.net/gregkh/linux/tty-2.5


thanks,

greg k-h

-----

ChangeSet@1.1308, 2003-06-13 12:36:16-07:00, Kurt.Robideau@comtrol.com
  [PATCH] Rocket patch against 2.5.70-bk18
  
  Here is rocket driver patch against 2.5.70-bk18.  Changes are:
  
  -  Removed non-GPL license text from headers
  -  Removed check_region()/request_region() raciness
  -  Made the driver a >2.5 driver only (as you had suggested)

 drivers/char/rocket.c     |  287 +++++-----------------------------------------
 drivers/char/rocket.h     |   24 ---
 drivers/char/rocket_int.h |   46 -------
 drivers/pci/pci.ids       |    2 
 include/linux/pci_ids.h   |    2 
 5 files changed, 44 insertions(+), 317 deletions(-)
------

