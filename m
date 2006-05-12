Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWELXbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWELXbh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWELXbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:31:37 -0400
Received: from ns1.suse.de ([195.135.220.2]:40125 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932148AbWELXbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:31:37 -0400
Date: Fri, 12 May 2006 16:29:40 -0700
From: Greg KH <greg@kroah.com>
To: drzeus-sdhci@drzeus.cx
Cc: sdhci-devel@list.drzeus.cx, linux-kernel@vger.kernel.org
Subject: sdhci needs card to be present when loading module.
Message-ID: <20060512232940.GA30610@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the 2.6.17-rc4 kernel (and 2.6.17-rc1), on my laptop, if you load the
sdhci driver with no SD card in the slot, it never seems to be able to
detect the insertion of a new card later on.

However, if I load the module with a card present.  Removing it and then
plugging it (or another one) in later seems to work just fine.

Is this expected?

Any kernel log messages I can provide to help with this?

thanks,

greg k-h
