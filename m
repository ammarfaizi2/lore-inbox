Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVCJBKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVCJBKi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262643AbVCJBGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:06:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:64415 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262641AbVCJAmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:38 -0500
Date: Wed, 9 Mar 2005 16:37:46 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] Add Superhighway bus support for 2.6.11
Message-ID: <20050310003746.GA32473@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is one changeset that adds superhighway bus support to the 2.6.11
kernel.  It has been in the -mm releases for a while.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/2.6.11/sh

Individual patches will follow, sent to the linux-kernel list.

thanks,

greg k-h

 drivers/sh/Makefile                      |    6 
 drivers/sh/superhyway/Makefile           |    7 +
 drivers/sh/superhyway/superhyway-sysfs.c |   45 ++++++
 drivers/sh/superhyway/superhyway.c       |  201 +++++++++++++++++++++++++++++++
 include/linux/superhyway.h               |   79 ++++++++++++
 5 files changed, 338 insertions(+)
-----


Paul Mundt:
  o Add SuperHyway bus subsystem

