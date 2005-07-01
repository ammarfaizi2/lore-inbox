Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263255AbVGAG5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263255AbVGAG5h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 02:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263257AbVGAG5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 02:57:36 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:59561 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S263255AbVGAG52
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 02:57:28 -0400
X-ORBL: [69.109.163.12]
From: Fedor Karpelevitch <fedor@karpelevitch.net>
To: Stefan Seyfried <seife@gmane0305.slipkontur.de>
Subject: Re: [ACPI] Re: AE_NO_MEMORY on ACPI init after memory upgrade and oops
Date: Thu, 30 Jun 2005 23:56:44 -0700
User-Agent: KMail/1.8.1
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200506300042.22255.fedor@karpelevitch.net> <20050630194954.GA20844@message-id.s3e.de> <2e3c17f30506301319704f6de0@mail.gmail.com>
In-Reply-To: <2e3c17f30506301319704f6de0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506302356.44979.fedor@karpelevitch.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fedor Karpelevitch wrote:
> > > > > I tried to upgrade memory on my laptop from 2 x 128m by
> > > > > replacing
> > > >
> > > > Did you override your DSDT?
> > >
> > > Yes, I did.
> >
> > So you need to modify your _new_ _original_ DSDT again after the
> > memory upgrade.
> > AFAIK the DSDT contains numbers that depend on the amount of
> > memory and is often built dynamically by the BIOS => even
> > changing some BIOS settings may change the DSDT.
> > --
> > Stefan Seyfried
>
> Thanks! I'll try it out. I thought DSDT was static...
>
> Fedor

removing custom DSDT worked. Fortunately all fixes in DSDT are 
non-critical.

Fedor.
