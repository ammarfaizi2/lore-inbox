Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbRBNPnL>; Wed, 14 Feb 2001 10:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbRBNPnA>; Wed, 14 Feb 2001 10:43:00 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:24083 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129069AbRBNPmr>;
	Wed, 14 Feb 2001 10:42:47 -0500
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
Cc: Gérard Roudier <groudier@club-internet.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Donald Becker <becker@scyld.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <Pine.LNX.3.96.1010213070337.31857F-100000@mandrakesoft.mandrakesoft.com>
From: Jes Sorensen <jes@linuxcare.com>
Date: 14 Feb 2001 16:39:39 +0100
In-Reply-To: Jeff Garzik's message of "Tue, 13 Feb 2001 07:06:44 -0600 (CST)"
Message-ID: <d3ofw55l50.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jeff" == Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com> writes:

Jeff> On 12 Feb 2001, Jes Sorensen wrote:
>> 3) The acenic/gbit performance anomalies have been cured by
>> reverting the PCI mem_inval tweaks.

Jeff> Just to be clear, acenic should or should not use MWI?

Jeff> And can a general rule be applied here?  Newer Tulip hardware
Jeff> also has the ability to enable/disable MWI usage, IIRC.

AceNIC always used to do this until the ZC patches appeared. It's a
recommendation from the hardware designers so I figure it's a bug in
the AceNIC hardware. I can probably go dig up the details on this, but
it's hidden somewhere deep down, ie. it's been ages since I looked at
it last.

Jes
