Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbULUMbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbULUMbu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 07:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbULUMbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 07:31:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36769 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261735AbULUMbs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 07:31:48 -0500
Date: Tue, 21 Dec 2004 12:31:46 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Greg KH <greg@kroah.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, willy@debian.org
Subject: Re: [PATCH] add PCI API to sysfs
Message-ID: <20041221123146.GA16109@parcelfarce.linux.theplanet.co.uk>
References: <200412201450.47952.jbarnes@engr.sgi.com> <20041220225817.GA21404@kroah.com> <200412201501.12575.jbarnes@engr.sgi.com> <1103613121.21771.28.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103613121.21771.28.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 08:12:01AM +0100, Benjamin Herrenschmidt wrote:
> treat all busses of a domain the same, but it leaves us with the
> necessary flexibility for setups with bridges that can remap the legacy
> space or that kind of thing.

Do any such bridges exist?  I've never heard of them.  io space accesses
are implemented by the host bridge, so I think the most generic we need
to support is one per host bridge, ie root bus.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
