Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131443AbRBQVhc>; Sat, 17 Feb 2001 16:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131382AbRBQVhV>; Sat, 17 Feb 2001 16:37:21 -0500
Received: from pizda.ninka.net ([216.101.162.242]:38828 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131086AbRBQVhG>;
	Sat, 17 Feb 2001 16:37:06 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14990.61040.981618.913167@pizda.ninka.net>
Date: Sat, 17 Feb 2001 13:34:40 -0800 (PST)
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
Cc: Jes Sorensen <jes@linuxcare.com>,
        Gérard Roudier <groudier@club-internet.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Donald Becker <becker@scyld.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <Pine.LNX.3.96.1010213070337.31857F-100000@mandrakesoft.mandrakesoft.com>
In-Reply-To: <d3n1brafoj.fsf@lxplus015.cern.ch>
	<Pine.LNX.3.96.1010213070337.31857F-100000@mandrakesoft.mandrakesoft.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik writes:
 > And in another message, On Mon, 12 Feb 2001, David S. Miller wrote:
 > > 3) The acenic/gbit performance anomalies have been cured
 > >    by reverting the PCI mem_inval tweaks.
 > 
 > 
 > Just to be clear, acenic should or should not use MWI?
 > 
 > And can a general rule be applied here?  Newer Tulip hardware also
 > has the ability to enable/disable MWI usage, IIRC.

I think this is an Acenic specific issue.  The second processor on the
Acenic board is only there to work around bugs in their DMA
controller.

Later,
David S. Miller
davem@redhat.com
