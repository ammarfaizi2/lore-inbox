Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262148AbSJ0ATP>; Sat, 26 Oct 2002 20:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262187AbSJ0ATP>; Sat, 26 Oct 2002 20:19:15 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:56482 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S262148AbSJ0ATO>; Sat, 26 Oct 2002 20:19:14 -0400
Date: Sat, 26 Oct 2002 17:25:26 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Support PCI device sorting (Re: PCI device order problem)
Message-ID: <20021026172526.A15641@lucon.org>
References: <3DBB0A81.6060909@pobox.com> <20021026144441.A13479@lucon.org> <3DBB1150.2030800@pobox.com> <20021026152043.A13850@lucon.org> <3DBB1743.6060309@pobox.com> <20021026155342.A14378@lucon.org> <3DBB1E29.5020402@pobox.com> <20021026165315.A15269@lucon.org> <3DBB2BE7.70208@pobox.com> <3DBB2DB9.3000803@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DBB2DB9.3000803@pobox.com>; from jgarzik@pobox.com on Sat, Oct 26, 2002 at 08:05:13PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2002 at 08:05:13PM -0400, Jeff Garzik wrote:
> Jeff Garzik wrote:
> 
> > s/__devinit/__init/ and the implementation looks ok to me
> 
> 
> 
> ...except if your patch can be called in hotplug paths...

There are plenty of __devini in arch/i386/kernel/pci-pc.c. I will leave
mine alone.


H.J.
