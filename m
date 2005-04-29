Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262962AbVD2U3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262962AbVD2U3R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 16:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbVD2UUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:20:23 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:59865 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262942AbVD2USp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 16:18:45 -0400
Subject: Re: [06/07] [PATCH] SCSI tape security: require CAP_ADMIN for
	SG_IO etc.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Kai Makisara <Kai.Makisara@kolumbus.fi>, Greg KH <gregkh@suse.de>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050429042014.GC25474@kroah.com>
References: <20050427171446.GA3195@kroah.com>
	 <20050427171649.GG3195@kroah.com>
	 <1114619928.18809.118.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0504280810140.12812@kai.makisara.local>
	 <1114694511.18809.187.camel@localhost.localdomain>
	 <20050429042014.GC25474@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114805784.18330.297.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 29 Apr 2005 21:16:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-04-29 at 05:20, Greg KH wrote:
> > Ok thats the bit I needed to know
> 
> So, do you still object to this patch being accepted?

Switched to CAP_SYS_RAWIO I don't. Its the wrong answer long term I
suspect but its definitely a good answer for now.

Alan

