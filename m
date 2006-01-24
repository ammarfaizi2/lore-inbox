Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWAXVNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWAXVNg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 16:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWAXVNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 16:13:36 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:26063 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750719AbWAXVNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 16:13:35 -0500
Subject: Re: 2.6.16-rc1-mm2 pata driver confusion
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Ed Sweetman <safemode@comcast.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <Pine.LNX.4.58.0601240907200.26036@shark.he.net>
References: <43D5CC88.9080207@comcast.net>
	 <1138116579.14675.22.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0601240904110.26036@shark.he.net>
	 <Pine.LNX.4.58.0601240907200.26036@shark.he.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 24 Jan 2006 21:13:53 +0000
Message-Id: <1138137233.14675.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-01-24 at 09:08 -0800, Randy.Dunlap wrote:
> > and while I'm looking at the config menu, why do both
> > Compaq Triflex and Intel PATA MPIIX say (Raving Lunatic)?
> 
> Lots of them say Raving Lunatic.  Are all of these Alan's libata
> patches?

They are a subset of them. The full patch now covers all the PCI devices
that are not platform specific except CMD640B if I counted right. It
also supports generic ISA, ISAPnP, PCMCIA and some VLB devices. 

Needless to say not all of this works and less of it has been heavily
tested yet.


