Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265786AbUFORft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265786AbUFORft (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 13:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265787AbUFORft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 13:35:49 -0400
Received: from mail.kroah.org ([65.200.24.183]:23723 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265786AbUFORfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 13:35:43 -0400
Date: Tue, 15 Jun 2004 10:34:13 -0700
From: Greg KH <greg@kroah.com>
To: marcelo.tosatti@cyclades.com, zaitcev@redhat.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB serial fixes for 2.4.27-pre6
Message-ID: <20040615173413.GA17264@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are 4 small fixes for some USB serial driver issues.  They have
all been in the 2.6 tree for some while now.  Pete suggested I send
these directly to you, instead of having to go through him.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/usb-2.4

The individual patches will be sent in follow up messages to this email
to you and the linux-usb-devel mailing list.

thanks,

greg k-h


 drivers/usb/serial/ftdi_sio.c |    7 +++
 drivers/usb/serial/ftdi_sio.h |    5 ++
 drivers/usb/serial/pl2303.c   |   11 ++++
 drivers/usb/serial/visor.c    |   98 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 119 insertions(+), 2 deletions(-)
-----

<andrej.filipcic:ijs.si>:
  o USB: pl2303 & input overruns

Greg Kroah-Hartman:
  o USB: fix empty write issue in pl2303 driver

Jan Capek:
  o USB ftdi device ids for 2.4

Martin Lubich:
  o USB: add Clie TH55 Support in visor kernel module

