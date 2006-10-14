Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbWJNDHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbWJNDHs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 23:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWJNDHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 23:07:48 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:2444 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1030230AbWJNDHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 23:07:47 -0400
Date: Fri, 13 Oct 2006 21:07:45 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Adam Belay <abelay@MIT.EDU>,
       Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Bug in PCI core
Message-ID: <20061014030745.GK11633@parisc-linux.org>
References: <1160780425.4792.275.camel@localhost.localdomain> <Pine.LNX.4.44L0.0610132229230.22133-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0610132229230.22133-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 10:33:04PM -0400, Alan Stern wrote:
> That seems like a reasonable thing to do.  (BTW, can anyone explain 
> quickly what "BIST" means?)

Built In Self Test.  Devices can take up to 2 seconds to complete the
test, and some drop off the PCI bus while doing it.

