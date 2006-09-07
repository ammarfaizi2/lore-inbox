Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751760AbWIGMdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbWIGMdx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 08:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbWIGMdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 08:33:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:428 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751760AbWIGMdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 08:33:52 -0400
Subject: Re: question regarding cacheline size
From: Arjan van de Ven <arjan@infradead.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Tejun Heo <htejun@gmail.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060907122311.GM2558@parisc-linux.org>
References: <44FFD8C6.8080802@gmail.com>
	 <20060907111120.GL2558@parisc-linux.org> <45000076.4070005@gmail.com>
	 <20060907120756.GA29532@flint.arm.linux.org.uk>
	 <20060907122311.GM2558@parisc-linux.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 07 Sep 2006 14:33:25 +0200
Message-Id: <1157632405.14882.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> So I think we should redo the PCI subsystem to set cacheline size during
> the buswalk rather than waiting for drivers to ask for it to be set.

... while allowing for quirks for devices that go puke when this
register gets written ;)

(afaik there are a few)



