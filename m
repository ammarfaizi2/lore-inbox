Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262886AbVAQVth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbVAQVth (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 16:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbVAQVtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 16:49:36 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:10400 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262886AbVAQVtP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:49:15 -0500
Date: Mon, 17 Jan 2005 13:47:27 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] W1 patch for 2.6.11-rc1
Message-ID: <20050117214727.GC28400@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a single drivers/w1 patch against the latest 2.6.11-rc1 tree.
This was included in the last -mm release.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/w1-2.6

thanks,

greg k-h

 drivers/w1/w1.c    |  210 ++++++++++++++++++++++++++++++++++-------------------
 drivers/w1/w1.h    |    5 +
 drivers/w1/w1_io.c |   10 ++
 drivers/w1/w1_io.h |    1 
 4 files changed, 154 insertions(+), 72 deletions(-)
-----


Evgeniy Polyakov:
  o w1: add ->search() method

