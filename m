Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265820AbRF2Jum>; Fri, 29 Jun 2001 05:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265821AbRF2Juc>; Fri, 29 Jun 2001 05:50:32 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14241 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265820AbRF2JuX>;
	Fri, 29 Jun 2001 05:50:23 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15164.18270.460245.219060@pizda.ninka.net>
Date: Fri, 29 Jun 2001 02:16:14 -0700 (PDT)
To: Jes Sorensen <jes@sunsite.dk>
Cc: Ben LaHaise <bcrl@redhat.com>,
        "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m achi ne
In-Reply-To: <d3pubo9pu4.fsf@lxplus015.cern.ch>
In-Reply-To: <15163.44990.304436.360220@pizda.ninka.net>
	<Pine.LNX.4.33.0106281830480.32276-100000@toomuch.toronto.redhat.com>
	<15163.45534.977835.569473@pizda.ninka.net>
	<d3pubo9pu4.fsf@lxplus015.cern.ch>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jes Sorensen writes:
 > Thats easy
 ...
 > This way you automatically get support for the situation Ben mentioned
 > as well, when doing large allocs and the IOMMU is full you return a
 > full 64 bit address.

And when the IOMMU is "full" what happens to all the SAC only
cards in the machine?  pci_map_{single,sg}() are not allowed
to fail.

See, it's not so easy.

Later,
David S. Miller
davem@redhat.com
