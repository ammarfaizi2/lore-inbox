Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVBOEYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVBOEYz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 23:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVBOEYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 23:24:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:10442 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261621AbVBOEYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 23:24:53 -0500
Date: Mon, 14 Feb 2005 20:24:35 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: my bk-pci and bk-driver trees are back up
Message-ID: <20050215042434.GA19193@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you put my bk-pci and bk-driver trees back into the next -mm
releases?  They are at:

	bk://kernel.bkbits.net/gregkh/linux/pci-2.6
and
	bk://kernel.bkbits.net/gregkh/linux/driver-2.6

Respectively.  I've pluled the 64bit resource stuff out of the pci tree,
that was causing a lot of problems.  It's in a separate bk tree for now
(at: bk://kernel.bkbits.net/gregkh/linux/resource-2.6 if anyone cares).

I've also pulled out the pm changes from my driver tree that were
causing the merge issues before, as I see Pavel has started to split
them up better.

For those who want to see patches of this stuff, big ones can be found
at:

PCI patch:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/pci/2.6/2.6.11-rc3/bk-pci-2.6.11-rc3-mm1.patch
PCI description:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/pci/2.6/2.6.11-rc3/bk-pci-2.6.11-rc3-mm1.patch.desc
	
64bit resource patch:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/pci/2.6/2.6.11-rc3/bk-resource-2.6.11-rc3-mm1.patch
64bit resource description:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/pci/2.6/2.6.11-rc3/bk-resource-2.6.11-rc3-mm1.patch.desc

driver patch:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/driver_core/2.6/2.6.11-rc4/bk-driver-2.6.11-rc4.patch
driver patch description:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/driver_core/2.6/2.6.11-rc4/bk-driver-2.6.11-rc4.patch.desc

thanks,

greg k-h
