Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269759AbUICTjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269759AbUICTjK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 15:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269770AbUICTif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:38:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3756 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269758AbUICTa2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:30:28 -0400
Date: Fri, 3 Sep 2004 20:30:27 +0100
From: Matthew Wilcox <willy@debian.org>
To: Greg KH <greg@kroah.com>, pcihpd-discuss@lists.sourceforge.net
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: ACPI pci hotplug patch series
Message-ID: <20040903193027.GO642@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A series of 5 patches coming up that make acpiphp work on an rx8620.
Unfortunately, they'll cause i386 to not work, so don't apply these
for now.

01-pci-bus-address.diff
Adds a way to convert from a global system address to a local pci bus address.

02-ia64-fixups.diff
Fix some bugs.  Nothing earth-shattering.

03-acpiphp-domains.diff
Make acpiphp handle domains properly

04-acpiphp-pcidev.diff
Prevent acpiphp from crashing the system in nasty untracable ways

05-acpiphp-misc.diff
Some minor cleanups

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
