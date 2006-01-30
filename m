Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWA3VeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWA3VeK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 16:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbWA3VeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 16:34:09 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:64923 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1030188AbWA3VeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 16:34:07 -0500
X-IronPort-AV: i="4.01,236,1136188800"; 
   d="scan'208"; a="1771651581:sNHT18534743392"
To: Greg KH <greg@kroah.com>
Cc: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>, Mark Maule <maule@sgi.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       "Patterson, Andrew D (Linux R&D)" <andrew.patterson@hp.com>
Subject: Re: FW: MSI-X on 2.6.15
X-Message-Flag: Warning: May contain useful information
References: <D4CFB69C345C394284E4B78B876C1CF10B8AC113@cceexc23.americas.cpqcorp.net>
	<20060130173852.GA16259@kroah.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 30 Jan 2006 13:33:49 -0800
In-Reply-To: <20060130173852.GA16259@kroah.com> (Greg KH's message of "Mon,
 30 Jan 2006 09:38:52 -0800")
Message-ID: <adafyn59z9e.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 30 Jan 2006 21:33:55.0474 (UTC) FILETIME=[DF3D3720:01C625E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> ia64 didn't really have msi support before the latest -mm
    Greg> kernel, right Mark?

No, I know Grant Grundler has been using MSI-X on ia64 with a PCI-X
InfiniBand HCA and the ib_mthca driver for quite a while, at least
since 2.6.11 or so.  ib_mthca uses 3 separate interrupts in MSI-X
mode, so even multiple messages from a single device are fine.

 - R.
