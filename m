Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267780AbUG3SSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267780AbUG3SSl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 14:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267781AbUG3SSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 14:18:40 -0400
Received: from omx3-ext.SGI.COM ([192.48.171.20]:2981 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267780AbUG3SR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 14:17:27 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Matthew Wilcox <willy@debian.org>
Subject: Re: Exposing ROM's though sysfs
Date: Fri, 30 Jul 2004 11:12:10 -0700
User-Agent: KMail/1.6.2
Cc: Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>,
       lkml <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz
References: <20040730165339.76945.qmail@web14929.mail.yahoo.com> <200407301057.12445.jbarnes@engr.sgi.com> <20040730181205.GW10025@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040730181205.GW10025@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407301112.10361.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 30, 2004 11:12 am, Matthew Wilcox wrote:
> How about reading the contents of the ROM at pci_scan_bus() time?  It'd
> waste a bunch of memory, but hey, people love sysfs.

That might be a good solution, actually.  Then it would be cached for devices 
that don't want you to look at it after they've been POSTed too.

Jesse
