Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbTJTSat (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 14:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTJTSat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 14:30:49 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:56448 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262675AbTJTSar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 14:30:47 -0400
Date: Mon, 20 Oct 2003 19:29:03 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310201829.h9KIT3pF000903@81-2-122-30.bradfords.org.uk>
To: David Lang <david.lang@digitalinsight.com>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Rik van Riel <riel@redhat.com>, "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Nuno Silva'" <nuno.silva@vgertech.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0310201046070.10996@dlang.diginsite.com>
References: <Pine.LNX.4.44.0310201153150.26888-100000@chimarrao.boston.redhat.com>
 <Pine.LNX.4.53.0310201204100.13739@chaos>
 <200310201749.h9KHnQ0C000781@81-2-122-30.bradfords.org.uk>
 <Pine.LNX.4.58.0310201046070.10996@dlang.diginsite.com>
Subject: RE: Blockbusting news, this is important (Re: Why are bad disk se ctors numbered strangely, and what happens to them?)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from David Lang <david.lang@digitalinsight.com>:
> rotating storage is hitting $1 per gig, memory is running ~$100/gig
> (substantially more for the highest density memory)
> 
> making a small solid state drive is easy, cheap and definantly has some
> uses, but making something that will replace stacks of 300G drives is
> neither cheap or easy.

Maybe one day local non-volitile storage won't even matter.

For example, say you were setting up a, (partial), mirror of kernel.org.

If you already had several machines in a datacentre, you could install
another one with no disks at all, just 4 GB of RAM, and configure it
to boot over the lan, loading the root filesystem in to a ramdisk.

Once booted, it could retrieve the parts of kernel.org that you wanted
to serve from a trusted mirror site, and begin serving.

Other such machines could use your machine as a trusted mirror site,
and eventually you could have lots of these machines all holding their
partial mirror of kernel.org in RAM.

As long as there is at least one on-line, any others can go down and
come up, and it doesn\'t really matter - they will just re-sync with
another node.

Of course, this would use up a lot of network bandwidth, but in the
future that may not matter.

Or, a more practical usage would be a load balanced cluster of
webservers - why bother with non-volitile storage in all of them?
Some of them could serve entirely from RAM, having booted over the
LAN.

John.
