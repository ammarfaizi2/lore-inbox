Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268251AbUIPRBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268251AbUIPRBg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 13:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268383AbUIPRA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 13:00:58 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:51654 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268253AbUIPQz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 12:55:28 -0400
Subject: Re: device driver for the SGI system clock, mmtimer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Christoph Lameter <clameter@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bob Picco <Robert.Picco@hp.com>, venkatesh.pallipadi@intel.com
In-Reply-To: <200409160909.12840.jbarnes@engr.sgi.com>
References: <200409161003.39258.bjorn.helgaas@hp.com>
	 <200409160909.12840.jbarnes@engr.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095349940.22739.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Sep 2004 16:52:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-16 at 17:09, Jesse Barnes wrote:
> I think Christoph already looked at that.  And HPET doesn't provide mmap 
> functionality, does it?  I.e. allow a userspace program to dereference the 
> counter register directly?

It can do but that assumes nothing else is mapped into the same page
that would be harmful or reveal information that should not be revealed
etc..

