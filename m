Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261537AbTCTPxu>; Thu, 20 Mar 2003 10:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261542AbTCTPxu>; Thu, 20 Mar 2003 10:53:50 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:58641 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261537AbTCTPxt>; Thu, 20 Mar 2003 10:53:49 -0500
Date: Thu, 20 Mar 2003 16:04:40 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jes Sorensen <jes@wildopensource.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Jeff Garzik <garzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fixup warning for acenic
Message-ID: <20030320160440.A14435@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jes Sorensen <jes@wildopensource.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Jeff Garzik <garzik@pobox.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <14240000.1048146629@[10.10.2.4]> <m365qenioq.fsf@trained-monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m365qenioq.fsf@trained-monkey.org>; from jes@wildopensource.com on Thu, Mar 20, 2003 at 10:47:49AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 10:47:49AM -0500, Jes Sorensen wrote:
> be. I have been reluctant to change the driver over to the new hotplug
> scheme since in the past there has been a significant number of AceNIC
> users running on older kernels which do not have the hotplug
> infrastructure (2.4.9 etc). On the other hand I don't remember hearing
> from a single person who wanted to use AceNIC in a hotplug
> environment.

2.4.9 of course has the newstyle pci interface! And actual hotplug
PCI support also is in all today singnificant 2.4.9 forks (RH..).

There's even some shim to emulate the pci_driver style interface on
2.2.

Anyway, this table has another use, it's used by userland ools like
installers for selecting the right driver for a given pci device.  So
even if it seems unused from kernelspace it has a use.

