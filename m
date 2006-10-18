Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422680AbWJRQpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422680AbWJRQpk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161233AbWJRQpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:45:40 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:27552 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161235AbWJRQp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:45:29 -0400
Subject: Re: [linux-pm] [PATCH] Block on access to temporarily unavailable
	pci device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Alan Stern <stern@rowland.harvard.edu>, Brian King <brking@us.ibm.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, Adam Belay <abelay@MIT.EDU>
In-Reply-To: <20061018160926.GS22289@parisc-linux.org>
References: <Pine.LNX.4.44L0.0610181151450.6766-100000@iolanthe.rowland.org>
	 <1161187503.9363.75.camel@localhost.localdomain>
	 <20061018160926.GS22289@parisc-linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Oct 2006 17:42:13 +0100
Message-Id: <1161189733.9363.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-18 am 10:09 -0600, ysgrifennodd Matthew Wilcox:
> On Wed, Oct 18, 2006 at 05:05:02PM +0100, Alan Cox wrote:
> > If the user specified O_NDELAY then -EWOULDBLOCK not wait
> 
> sysfs doesn't give us the struct file, so we can't tell.

I'm all for fixing sysfs on that point so that it can behave sensibly.

