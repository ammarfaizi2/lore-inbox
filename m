Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264175AbTDWRsf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 13:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264178AbTDWRsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 13:48:35 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:63649 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264175AbTDWRsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 13:48:33 -0400
Date: Wed, 23 Apr 2003 11:02:10 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.4.21-rc1
Message-ID: <20030423180210.GA11995@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are three USB bugfixes for 2.4.21-rc1.  They are two fixes for the
usb-storage driver, and one fix for the keyspan driver.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/marcelo-2.4

The individual patches will be sent in follow up messages to this email
to you and the linux-usb-devel mailing list.

thanks,

greg k-h

 drivers/usb/serial/keyspan.c    |   15 +++++++++------
 drivers/usb/serial/keyspan.h    |   20 +++++++++++++++++++-
 drivers/usb/storage/transport.c |   10 +++++++++-
 drivers/usb/storage/usb.h       |    1 +
 4 files changed, 38 insertions(+), 8 deletions(-)
-----

<lucy@innosys.com>:
  o USB: keyspan driver fixes

Alan Stern <stern@rowland.harvard.edu>:
  o USB: usb-storage fixes
  o USB: usb storage async unlink error code fix

