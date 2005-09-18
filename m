Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbVIRCli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbVIRCli (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 22:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbVIRClh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 22:41:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15314 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751276AbVIRClh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 22:41:37 -0400
Date: Sat, 17 Sep 2005 22:41:27 -0400
From: Dave Jones <davej@redhat.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Bernardo Innocenti <bernie@develer.com>,
       Matheus Izvekov <izvekov@lps.ele.puc-rio.br>,
       Development discussions related to Fedora Core 
	<fedora-devel-list@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Assertion failed in libata-core.c:ata_qc_complete(3051)
Message-ID: <20050918024127.GA23405@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jesper Juhl <jesper.juhl@gmail.com>,
	Bernardo Innocenti <bernie@develer.com>,
	Matheus Izvekov <izvekov@lps.ele.puc-rio.br>,
	Development discussions related to Fedora Core <fedora-devel-list@redhat.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <432BA524.40301@develer.com> <60030.200.141.101.221.1126969752.squirrel@correio.lps.ele.puc-rio.br> <432CB177.5070001@develer.com> <9a87484905091717524adfc854@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a87484905091717524adfc854@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2005 at 02:52:55AM +0200, Jesper Juhl wrote:
 > On 9/18/05, Bernardo Innocenti <bernie@develer.com> wrote:
 > > Matheus Izvekov wrote:
 > > 
 > > >>I have a Promise TX4 controller with 4 SATA drivers
 > > >>formatted with a RAID1 and a RAID5 md.  LVM on top of this.
 > > >
 > > > Can you reproduce this with a stock kernel?
 > > 
 > > I've just opened the case to install some more RAM and
 > > noticed that the SATA controller card wasn't completely
 > > fitted into the PCI slot.  Could it be just a hardware
 > > problem?  I don't know what that assartion is about.
 > > 
 > > Nowadays, Fedora kernels don't differ much from stock
 > > kernels plus the usual bugfixes.  I've now upgraded to
 > 
 > They still do differ though. When asked to retest with a stock kernel,
 > indulging the person who asks is usually a good idea if you want your
 > problem solved :)

libata / scsi layer in that kernel should be 1:1 to mainline
as of 2.6.12

		Dave
