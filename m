Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267130AbSKMHkn>; Wed, 13 Nov 2002 02:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267128AbSKMHkn>; Wed, 13 Nov 2002 02:40:43 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:28359 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267130AbSKMHkn>; Wed, 13 Nov 2002 02:40:43 -0500
To: Greg KH <greg@kroah.com>
Cc: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>,
       Matthew Wilcox <willy@debian.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, andmike@us.ibm.com, hch@lst.de,
       linux-kernel@vger.kernel.org, mochel@osdl.org,
       parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device interface
References: <20021109060342.GA7798@kroah.com>
	<200211091533.gA9FXuW02017@localhost.localdomain>
	<20021113061310.GD2106@kroah.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 13 Nov 2002 16:46:58 +0900
In-Reply-To: <20021113061310.GD2106@kroah.com>
Message-ID: <buon0odsyh9.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:
> What is the real reason for needing this, pci_alloc_consistent()?  We
> have talked about renaming that to dev_alloc_consistent() in the past,
> which I think will work for you, right?

This this would end up [or have the ability to] invoking a bus-specific
routine at some point, right?  [so that a truly PCI-specific definition
could be still be had]

Thanks,

-Miles
-- 
[|nurgle|]  ddt- demonic? so quake will have an evil kinda setting? one that 
            will  make every christian in the world foamm at the mouth? 
[iddt]      nurg, that's the goal 
