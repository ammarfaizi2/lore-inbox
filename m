Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751703AbWGZQbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbWGZQbQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 12:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbWGZQbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 12:31:16 -0400
Received: from mxl145v67.mxlogic.net ([208.65.145.67]:23431 "EHLO
	p02c11o144.mxlogic.net") by vger.kernel.org with ESMTP
	id S1751702AbWGZQbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 12:31:15 -0400
Date: Wed, 26 Jul 2006 19:32:26 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       Roland Dreier <rolandd@cisco.com>, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: restore missing PCI registers after reset
Message-ID: <20060726163226.GG9411@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060726162007.GA9871@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060726162007.GA9871@suse.de>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 26 Jul 2006 16:36:47.0734 (UTC) FILETIME=[B031B960:01C6B0D1]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Greg KH <gregkh@suse.de>:
> I think pci_restore_state() already restores the msi and msix state,
> take a look at the latest kernel version :)

Yes, I know :)
but I am not talking abotu MSI/MSI-X, I am talking about the following:
> > >   PCI-X device: PCI-X command register
> > >   PCI-X bridge: upstream and downstream split transaction registers
> > >   PCI Express : PCI Express device control and link control registers

these register values include maxumum MTU for PCI express and other vital
data.

-- 
MST
