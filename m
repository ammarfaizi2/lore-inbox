Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWIEVT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWIEVT6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 17:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWIEVT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 17:19:57 -0400
Received: from gate.crashing.org ([63.228.1.57]:7615 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751179AbWIEVT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 17:19:56 -0400
Subject: Re: pci error recovery procedure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>, linuxppc-dev@ozlabs.org,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Yanmin Zhang <yanmin.zhang@intel.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>
In-Reply-To: <20060905185020.GD7139@austin.ibm.com>
References: <1157008212.20092.36.camel@ymzhang-perf.sh.intel.com>
	 <20060831175001.GE8704@austin.ibm.com>
	 <1157081629.20092.167.camel@ymzhang-perf.sh.intel.com>
	 <20060901212548.GS8704@austin.ibm.com>
	 <1157348850.20092.304.camel@ymzhang-perf.sh.intel.com>
	 <1157360592.22705.46.camel@localhost.localdomain>
	 <20060905185020.GD7139@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 06 Sep 2006 07:19:11 +1000
Message-Id: <1157491152.22705.133.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 13:50 -0500, Linas Vepstas wrote:
> On Mon, Sep 04, 2006 at 07:03:12PM +1000, Benjamin Herrenschmidt wrote:
> > 
> > > As you know, all functions of a device share the same bus number and 5 bit dev number.
> > > They just have different 3 bit function number. We could deduce if functions are in the same
> > > device (slot).
> > 
> > Until you have a P2P bridge ...
> 
> And this is not theoretical: for example, the matrox graphics cards:
> 
> 0000:c8:01.0 PCI bridge: Hint Corp HB6 Universal PCI-PCI bridge (non-transparent mode) (rev 13)
> 0000:c9:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 85)

It's also very common with multiple ports network cards

Ben.


