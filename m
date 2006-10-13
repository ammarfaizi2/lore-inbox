Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWJMQnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWJMQnG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWJMQnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:43:06 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:4266 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751339AbWJMQnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:43:04 -0400
Subject: Re: [linux-pm] Bug in PCI core
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam Belay <abelay@MIT.EDU>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <1160757260.26091.115.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0610131024340.6460-100000@iolanthe.rowland.org>
	 <1160753187.25218.52.camel@localhost.localdomain>
	 <1160753390.3000.494.camel@laptopd505.fenrus.org>
	 <1160755562.25218.60.camel@localhost.localdomain>
	 <1160757260.26091.115.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Oct 2006 18:09:09 +0100
Message-Id: <1160759349.25218.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-13 am 12:34 -0400, ysgrifennodd Adam Belay:
> I agree this needs to be fixed.  However, as I previously mentioned,
> this isn't the right place to attack the problem.  Remember, this wasn't
> originally a kernel regression.  Rather it's a workaround for a known

It's a kernel regression. It used to be reliable to read X resource
addresses at any time.

> Finally, it's worth noting that this issue is really a corner-case, and
> in most systems it's extremely rare that even incorrect userspace apps
> would have any issue.

Except just occasionally and randomly in the field, probably almost
undebuggable and irreproducable - the very worst conceivable kind of
bug.

