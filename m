Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVDEKFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVDEKFx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 06:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVDEKDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 06:03:15 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.27]:12614 "EHLO smtp4.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261667AbVDEJtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:49:46 -0400
X-ME-UUID: 20050405094945273.42B3E1C003FC@mwinf0407.wanadoo.fr
Date: Tue, 5 Apr 2005 11:46:25 +0200
To: Arjan van de Ven <arjan@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Ian Campbell <ijc@hellion.org.uk>,
       Sven Luther <sven.luther@wanadoo.fr>, "Theodore Ts'o" <tytso@mit.edu>,
       Greg KH <greg@kroah.com>, Michael Poole <mdpoole@troilus.org>,
       debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050405094625.GA13687@pegasos>
References: <20050404192945.GB1829@pegasos> <20050404205527.GB8619@thunk.org> <20050404211931.GB3421@pegasos> <1112689164.3086.100.camel@icampbell-debian> <20050405083217.GA22724@pegasos> <1112690965.3086.107.camel@icampbell-debian> <20050405091144.GA18219@lst.de> <1112693287.6275.30.camel@laptopd505.fenrus.org> <20050405093258.GA18523@lst.de> <1112693819.6275.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1112693819.6275.36.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 11:36:58AM +0200, Arjan van de Ven wrote:
> 
> > > Second step is to make the built-in firmware a
> > > config option and then later on when the infrastructure matures for
> > > firmware loading/providing firmware it can be removed from the driver
> > > entirely.
> > 
> > I think the infrasturcture is quite mature.  We have a lot of drivers
> > that require it to function.
> 
> what seems to be currently missing is distro level support for using
> firmware for modules needed for booting (and tg3 falls sort of under
> that via nfsroot) and widespread easy availability of firmware in
> distros and for users.

Well, apart from the installation case, simply using such kernel is easy
enough, if you use an initrd. The mkinitrd script only has to be aware of
this, and include the needed firmware in the initrd, as it does for the
modules. Initial installation will have to either have the possibility to
build custom initrds with the firmware blobs in it, or a way to easily get
those firmware blobs (from CD, floppy, net, ...), or have support for a second
initrd which would contain the firmware. I don't believe there is already
support for a second ramdisk in todays kernel.

Friendly,

Sven Luther

