Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265492AbUF2GNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265492AbUF2GNR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 02:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbUF2GNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 02:13:17 -0400
Received: from palrel12.hp.com ([156.153.255.237]:46492 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S265492AbUF2GNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 02:13:15 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16609.2168.754171.270072@napali.hpl.hp.com>
Date: Mon, 28 Jun 2004 23:13:12 -0700
To: arjanv@redhat.com
Cc: davidm@hpl.hp.com, Jeff Garzik <jgarzik@pobox.com>,
       Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 32-bit dma allocations on 64-bit platforms
In-Reply-To: <1088234187.2805.3.camel@laptop.fenrus.com>
References: <20040623183535.GV827@hygelac>
	<40D9D7BA.7020702@pobox.com>
	<16605.1055.383447.805653@napali.hpl.hp.com>
	<1088234187.2805.3.camel@laptop.fenrus.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 26 Jun 2004 09:16:27 +0200, Arjan van de Ven <arjanv@redhat.com> said:

  Arjan> the real solution is an iommu of course, but the highmem
  Arjan> solution has quite some merit too..... I know you disagree
  Arjan> with me on that one though.

Yes, some merits and some faults.  The real solution is iommu or
64-bit capable devices.  Interesting that graphics controllers should
be last to get 64-bit DMA capability, considering how much more
complex they are than disk controllers or NICs.

	--david
