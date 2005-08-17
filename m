Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbVHQMP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbVHQMP2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 08:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVHQMP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 08:15:28 -0400
Received: from smtp1.brturbo.com.br ([200.199.201.163]:52672 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1751106AbVHQMP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 08:15:27 -0400
Subject: Re: [Fwd: help with PCI hotplug and a PCI device enabled after
	boot]
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200508171411.26865@bilbo.math.uni-mannheim.de>
References: <1124269343.4423.35.camel@localhost>
	 <200508171315.32704@bilbo.math.uni-mannheim.de>
	 <1124279580.4423.50.camel@localhost>
	 <200508171411.26865@bilbo.math.uni-mannheim.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 17 Aug 2005 09:15:03 -0300
Message-Id: <1124280903.4423.55.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-6mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eike,

Em Qua, 2005-08-17 às 14:11 +0200, Rolf Eike Beer escreveu:
> Mauro Carvalho Chehab wrote:
> >Em Qua, 2005-08-17 às 13:15 +0200, Rolf Eike Beer escreveu:
> 
> >> Damn, I should stop editing diffs by hand.
> >
> >	I'm also have this old habbit ;-)
> 
> That doesn't make it any better :)
> 
> >> Change this to
> >> pci_bus_assign_resources and it should work. Sorry.
> >
> >	It works, but produced an oops (attached).
> 
> Looks like this is caused by your driver, I can't see any of my functions in 
> the strace.

	It is possible. Maybe the chip needs something else to avoid generating
a IRQ event before completing initialization.

	Thanks for your handful help !
> Eike

Cheers, 
Mauro.

