Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVD0Sxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVD0Sxd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 14:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVD0Sxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 14:53:33 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:2505 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261948AbVD0SxR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 14:53:17 -0400
Subject: Re: [06/07] [PATCH] SCSI tape security: require CAP_ADMIN for
	SG_IO etc.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <gregkh@suse.de>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, Kai.Makisara@kolumbus.fi,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org
In-Reply-To: <20050427182610.GA4400@suse.de>
References: <20050427171446.GA3195@kroah.com>
	 <20050427171649.GG3195@kroah.com>
	 <1114619928.18809.118.camel@localhost.localdomain>
	 <20050427182610.GA4400@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114624288.18809.122.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 27 Apr 2005 18:51:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-04-27 at 19:26, Greg KH wrote:
> > This patch is just wrong on so many different levels its hard to know
> > where to begin.
> 
> But that is what is now in mainline, right?  If so, all of these
> questions still pertain to the current tree...

Correct, the 12rc code is also completely wrong. Good job we caught it
since its apparently not been reviewed properly until now.


