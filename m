Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWIEXXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWIEXXI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 19:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWIEXXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 19:23:08 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:32746 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932213AbWIEXXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 19:23:06 -0400
Subject: Re: Linux 2.6.18-rc6
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Olaf Hering <olaf@aepfle.de>, Linus Torvalds <torvalds@osdl.org>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1157494837.22705.151.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org>
	 <20060905122656.GA3650@aepfle.de>
	 <1157490066.3463.73.camel@mulgrave.il.steeleye.com>
	 <1157494837.22705.151.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 18:22:47 -0500
Message-Id: <1157498567.3463.91.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-06 at 08:20 +1000, Benjamin Herrenschmidt wrote:
> Yes, it's a PCI error.

Thanks, and the cat of /proc/scsi_host/host<n>/signalling?

My suspicion is the register doesn't actually exist on this card so it
doesn't actually respond on the bus.  However, on my equivalent
everything works; largely I think because the only PC's I have don't
know how to signal a PCI error.

James


