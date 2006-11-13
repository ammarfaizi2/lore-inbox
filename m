Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754002AbWKMGIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002AbWKMGIF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 01:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753990AbWKMGIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 01:08:04 -0500
Received: from gate.crashing.org ([63.228.1.57]:43181 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1754002AbWKMGIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 01:08:04 -0500
Subject: Re: [PATCH 0/2] Add dev_sysdata and use it for ACPI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Greg KH <greg@kroah.com>, Cornelia Huck <cornelia.huck@de.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <17751.65522.993927.170279@cargo.ozlabs.ibm.com>
References: <1163033121.28571.792.camel@localhost.localdomain>
	 <20061109170435.07d2e0c4@gondolin.boeblingen.de.ibm.com>
	 <1163111737.4982.40.camel@localhost.localdomain>
	 <20061110054846.GA9137@kroah.com>
	 <17751.65522.993927.170279@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 13 Nov 2006 17:07:45 +1100
Message-Id: <1163398066.4982.282.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 16:17 +1100, Paul Mackerras wrote:
> Greg KH writes:
> 
> > Care to respin these patches with this change?
> > 
> > And yes, I don't see a problem with such a change like this for 2.6.20,
> > it's pretty simple.
> 
> I need to put Ben's "Add arch specific dev_archdata to struct device"
> patch into my tree in the for-2.6.20 branch, because it creates
> include/asm-powerpc/device.h, and I have other patches queued up which
> touch include/asm-powerpc/device.h.
> 
> Greg, if you want you can drop that patch, and Linus' tree will get it
> via my tree, or if that's difficult, Linus' tree will get it from both
> directions.  I'm sure git will sort it out. :)

Greg: Note that the patch paulus has is the respin I posted on Saturday
with the name change and the use of include/asm-generic/ as suggested by
Steven.

Ben.


