Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268203AbUHYSaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268203AbUHYSaa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 14:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268224AbUHYSaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 14:30:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62701 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268203AbUHYS3z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 14:29:55 -0400
Date: Wed, 25 Aug 2004 19:29:54 +0100
From: Matthew Wilcox <willy@debian.org>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Martin Mares <mj@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040825182954.GG16196@parcelfarce.linux.theplanet.co.uk>
References: <20040825174238.GA26714@kroah.com> <20040825180607.10858.qmail@web14930.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040825180607.10858.qmail@web14930.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 11:06:06AM -0700, Jon Smirl wrote:
> Final version, I hope, includes short decription and Signed-off-by at
> top of patch.

+/**
+ * pci_remove_rom - disable the ROM and remove it's sysfs attribute
+ * @dev: pointer to pci device struct
+ * 
+ */

It's its, not it's, unless of course you mean it is, in which case it's
it's not its.

More helpfully, "its" is a pronoun like "his" or "hers".  "it's" is an
abbreviation for "it is".

Also, this is a mistake:

+/**
+ * pci_remove_rom - disable the ROM and remove it's sysfs attribute
+ * @dev: pointer to pci device struct
+ *
+ */
+void 
+pci_cleanup_rom(struct pci_dev *pdev) 

I'd like a little bit of description about the difference between
pci_cleanup_rom and pci_remove_rom in the docbook, please.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
