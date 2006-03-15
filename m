Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932578AbWCOBiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbWCOBiu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 20:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWCOBiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 20:38:50 -0500
Received: from mtaout4.012.net.il ([84.95.2.10]:35391 "EHLO mtaout4.012.net.il")
	by vger.kernel.org with ESMTP id S932578AbWCOBit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 20:38:49 -0500
Date: Wed, 15 Mar 2006 03:38:20 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [RFC PATCH 3/3] x86-64: Calgary IOMMU - hook it in
In-reply-to: <20060315000621.GC7699@us.ibm.com>
To: Jon Mason <jdmason@us.ibm.com>
Cc: Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@suse.de>,
       Muli Ben-Yehuda <MULI@il.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Message-id: <20060315013820.GL23631@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060314082432.GE23631@granada.merseine.nu>
 <20060314082552.GF23631@granada.merseine.nu>
 <20060314082634.GG23631@granada.merseine.nu>
 <20060314230348.GC1579@elf.ucw.cz> <20060314232247.GB7699@us.ibm.com>
 <20060314232612.GC1785@elf.ucw.cz> <20060315000621.GC7699@us.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 06:06:21PM -0600, Jon Mason wrote:

> > No, it was pretty clear. But unless these machines are pretty common,
> > I'd suggest users to say N. ... its like most drivers, it takes space
> > but no other harm. Still we don't want to say "say Y" on all drivers.
> 
> Ah, I understand your point now.  I'll fixup the comment and default
> value.

I disagree - I think it's quite enough that it depends on EXPERIMENTAL
&& MPSC. Also, gart is default Y as well.
 
> > ...it is not required for boot on IBM x366 machines, is it?
> 
> No, it is not.

... but defaulting it to Y has significant advantages at this stage,
not the least of which is that it will get us more testing :-)

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

