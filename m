Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753921AbWKMFRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921AbWKMFRo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 00:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753923AbWKMFRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 00:17:44 -0500
Received: from ozlabs.org ([203.10.76.45]:25728 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1753921AbWKMFRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 00:17:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17751.65522.993927.170279@cargo.ozlabs.ibm.com>
Date: Mon, 13 Nov 2006 16:17:38 +1100
From: Paul Mackerras <paulus@samba.org>
To: Greg KH <greg@kroah.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Cornelia Huck <cornelia.huck@de.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/2] Add dev_sysdata and use it for ACPI
In-Reply-To: <20061110054846.GA9137@kroah.com>
References: <1163033121.28571.792.camel@localhost.localdomain>
	<20061109170435.07d2e0c4@gondolin.boeblingen.de.ibm.com>
	<1163111737.4982.40.camel@localhost.localdomain>
	<20061110054846.GA9137@kroah.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:

> Care to respin these patches with this change?
> 
> And yes, I don't see a problem with such a change like this for 2.6.20,
> it's pretty simple.

I need to put Ben's "Add arch specific dev_archdata to struct device"
patch into my tree in the for-2.6.20 branch, because it creates
include/asm-powerpc/device.h, and I have other patches queued up which
touch include/asm-powerpc/device.h.

Greg, if you want you can drop that patch, and Linus' tree will get it
via my tree, or if that's difficult, Linus' tree will get it from both
directions.  I'm sure git will sort it out. :)

Paul.

