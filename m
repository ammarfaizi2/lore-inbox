Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261978AbSJ0AGL>; Sat, 26 Oct 2002 20:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261984AbSJ0AGL>; Sat, 26 Oct 2002 20:06:11 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:39372 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261978AbSJ0AGK>; Sat, 26 Oct 2002 20:06:10 -0400
Subject: Re: PATCH: Support PCI device sorting (Re: PCI device order problem)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "H. J. Lu" <hjl@lucon.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DBB2DB9.3000803@pobox.com>
References: <20021025202600.A3293@lucon.org> <3DBB0553.5070805@pobox.com>
	<20021026142704.A13207@lucon.org> <3DBB0A81.6060909@pobox.com>
	<20021026144441.A13479@lucon.org> <3DBB1150.2030800@pobox.com>
	<20021026152043.A13850@lucon.org> <3DBB1743.6060309@pobox.com>
	<20021026155342.A14378@lucon.org> <3DBB1E29.5020402@pobox.com>
	<20021026165315.A15269@lucon.org> <3DBB2BE7.70208@pobox.com> 
	<3DBB2DB9.3000803@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Oct 2002 01:30:22 +0100
Message-Id: <1035678622.13244.138.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-27 at 01:05, Jeff Garzik wrote:
> Jeff Garzik wrote:
> 
> > s/__devinit/__init/ and the implementation looks ok to me
> 
> 
> 
> ...except if your patch can be called in hotplug paths...

We can't go around re-sorting the PCI devices. The pci lists are not
locked sanely as it is

