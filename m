Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbTFEUrk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 16:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbTFEUqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:46:55 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:37284 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264864AbTFEUqG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:46:06 -0400
Date: Thu, 5 Jun 2003 13:50:29 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] Yet more USB changes for 2.5.70
Message-ID: <20030605205029.GA6788@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more USB changes and fixes for 2.5.70.  These include a
documentaton update for the USB gadget drivers, and a bug fix for USB
keyboards that was caused by the previous patches sent to you.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/linus-2.5

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 Documentation/DocBook/Makefile    |    3 
 Documentation/DocBook/gadget.tmpl |  966 ++++++++++++++++++++++++++++++++++++++
 drivers/usb/image/hpusbscsi.c     |   11 
 drivers/usb/input/hid-input.c     |   97 +--
 drivers/usb/input/hid.h           |    3 
 drivers/usb/serial/empeg.c        |    5 
 6 files changed, 1022 insertions(+), 63 deletions(-)
-----


Ben Collins:
  o USB: fix keyboard leds

David Brownell:
  o USB: kerneldoc for gadget API

Oliver Neukum:
  o USB: usb_set_configuration in empeg.c
  o USB: cut usb_set_config from hpusbscsi

