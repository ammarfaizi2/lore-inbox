Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272420AbTGaJeT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 05:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272443AbTGaJeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 05:34:19 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:32384 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S272420AbTGaJeS (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 05:34:18 -0400
Date: Thu, 31 Jul 2003 10:41:16 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307310941.h6V9fGIL000804@81-2-122-30.bradfords.org.uk>
To: bunk@fs.tum.de, szepe@pinerecords.com
Subject: Re: [2.6 patch] let broken drivers depend on BROKEN{,ON_SMP}
Cc: john@grabjohn.com, Linux-Kernel@vger.kernel.org, Riley@Williams.Name
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > If a _user_ of a stable kernel notices "it doesn't even compile" this 
> > > > gives a very bad impression of the quality of the Linux kernel.
> > > 
> > > The keyword in this sentence is "stable."
> > > Could you maybe come up with this again at around 2.6.40? :)
> > 
> > The first stable kernel of the 2.6 kernel series will be 2.6.0.
>
> There are going to be a zillion drivers that don't compile by the
> time 2.6.0 is released, which is precisely when lkml will see a whole
> new wave of people willing to fix things so I really don't think
> hiding the problems behind CONFIG_BROKEN or whatever is reasonable.

They would simply stay behind CONFIG_BROKEN for longer, because fewer
people would test them.

Also, remember that some things might only give compile errors under
certain circumstances.  The _vast_ majority of kernels include TCP/IP
support, for example, so something that breaks when it's not
configured could easily go unnoticed for ages - does that mean it
should be put behind CONFIG_BROKEN when it's discovered?

John.
