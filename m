Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbUCDFxy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 00:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbUCDFxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 00:53:54 -0500
Received: from [64.65.177.98] ([64.65.177.98]:60642 "EHLO mail.pacrimopen.com")
	by vger.kernel.org with ESMTP id S261460AbUCDFxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 00:53:14 -0500
Subject: devfs b0rks in 2.6.2, 2.6.3
From: "Joshua M. Schmidlkofer" <menion@asylumwear.com>
To: linux-kernel@vger.kernel.org
Cc: pacopablo@pacopablo.com
Content-Type: text/plain
Message-Id: <1078379594.10353.20.camel@menion.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 03 Mar 2004 21:53:14 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This report is in the interest of posterity, and giving people with
similar bugs a search result.  I don't need a fix because udev works
100%.  However, I was unable to make devfs work at all in 2.6.2, and
2.6.3.  I tried a lot of things, and it seemed to be locking when
creating tty's after hotplug events.  In any case, especially usb the
hotplug stuff seemed to trigger process freezes.  The init process would
suddenly stop.  I SysRq worked fine, but as I was in a hurry, I did not
try to do more troubleshooting.  I was never able to fully boot into a
2.6.2 or 2.6.3 kernel on my box with devfs enabled.

I recovered, and removed devfs, converted my gentoo install to udev, and
have had no trouble since.

thanks,
  joshua

[and thanks greg k-h et al. for making udev!!]

