Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423793AbWJaSyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423793AbWJaSyW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 13:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423794AbWJaSyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 13:54:22 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:3569 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1423793AbWJaSyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 13:54:21 -0500
Message-ID: <45479A20.10304@oracle.com>
Date: Tue, 31 Oct 2006 10:46:56 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, gregkh <greg@kroah.com>
Subject: modpost warning: class mask
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Should we be concerned about this warning?

WARNING: Can't handle masks in drivers/ide/pci/atiixp:FFFF05

from drivers/ide/pci/atiixp.c:

	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, PCI_ANY_ID, PCI_ANY_ID, (PCI_CLASS_STORAGE_IDE<<8)|0x8a, 0xffff05, 1},

-- 
~Randy
