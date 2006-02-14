Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422691AbWBNRUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422691AbWBNRUU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 12:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422692AbWBNRUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 12:20:20 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:48536 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1422691AbWBNRUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 12:20:18 -0500
X-IronPort-AV: i="4.02,114,1139212800"; 
   d="scan'208"; a="1776299931:sNHT2061738198"
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Roland Dreier <rolandd@cisco.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: AMD 8131 and MSI quirk
X-Message-Flag: Warning: May contain useful information
References: <524q799p2t.fsf@cisco.com> <20060214165222.GC12974@mellanox.co.il>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 14 Feb 2006 09:19:49 -0800
In-Reply-To: <20060214165222.GC12974@mellanox.co.il> (Michael S. Tsirkin's
 message of "Tue, 14 Feb 2006 18:52:22 +0200")
Message-ID: <adabqx9vowa.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 14 Feb 2006 17:20:16.0030 (UTC) FILETIME=[EBF09BE0:01C6318A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Michael> The following should do this IMO. Roland, could you test
    Michael> this patch please?

I'll need to find a system with the required setup; unfortunately I
don't have one myself.

What's required is an Opteron motherboard with both an AMD 8131 PCI-X
bridge and a PCI Express slot (typically Nvidia Nforce4), and an
MSI-capable device (such as a Mellanox HCA) on the PCIe bus.  I know
that eg Tyan makes such a motherboard.  Does anyone reading this have
a setup like that?

 - R.
