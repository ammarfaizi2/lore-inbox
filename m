Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271341AbTHMDCk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 23:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271343AbTHMDCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 23:02:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:45505 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271341AbTHMDCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 23:02:39 -0400
Message-ID: <32835.4.4.25.4.1060743746.squirrel@www.osdl.org>
Date: Tue, 12 Aug 2003 20:02:26 -0700 (PDT)
Subject: Re: C99 Initialisers
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <davej@redhat.com>
In-Reply-To: <20030813004941.GD2184@redhat.com>
References: <20030812020226.GA4688@zip.com.au>
        <1060654733.684.267.camel@localhost>
        <20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk>
        <20030812053826.GA1488@kroah.com>
        <20030812112729.GF3169@parcelfarce.linux.theplanet.co.uk>
        <20030812180158.GA1416@kroah.com>
        <3F397FFB.9090601@pobox.com>
        <20030812171407.09f31455.rddunlap@osdl.org>
        <3F3986ED.1050206@pobox.com>
        <20030812173742.6e17f7d7.rddunlap@osdl.org>
        <20030813004941.GD2184@redhat.com>
X-Priority: 3
Importance: Normal
Cc: <rddunlap@osdl.org>, <jgarzik@pobox.com>, <greg@kroah.com>,
       <willy@debian.org>, <davem@redhat.com>, <linux-kernel@vger.kernel.org>,
       <kernel-janitor-discuss@lists.sourceforge.net>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Aug 12, 2003 at 05:37:42PM -0700, Randy.Dunlap wrote:
>  > | I would much rather move the PCI ids out of the
>  > | drivers altogether, into some metadata file(s) in the kernel source  |
> tree, than bloat up tg3, tulip, e100, and the other PCI id-heavy  |
> drivers' source code.
>  >
>  > That last few lines certainly sounds desirable.
>
> What exactly would be the benefit of this ?
> The only thing I could think of was out-of-kernel tools to do
> things like matching modules to pci IDs, but that seems to be
> done mechanically by various distros already reading the pci_driver structs.

Maybe I read too much into it.  It made me think of Jeff's previous
remarks about driver config and help being close to but split from
driver source code.  I saw (read) it as an extension of that:
a way to package all driver information neatly close together,
but in separate files.  Someone could modify the config, help, or IDs
file(s) without mucking with the driver source file(s).

~Randy



