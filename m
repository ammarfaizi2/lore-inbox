Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130017AbRBYXto>; Sun, 25 Feb 2001 18:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130034AbRBYXte>; Sun, 25 Feb 2001 18:49:34 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:43920 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130017AbRBYXtX>; Sun, 25 Feb 2001 18:49:23 -0500
Message-ID: <3A9999FD.AEFC4570@coplanar.net>
Date: Sun, 25 Feb 2001 18:49:17 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: jdthoodREMOVETHIS@yahoo.co.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: Should isa-pnp utilize the PnP BIOS?
In-Reply-To: <20010214092251.D1144@e-trend.de> <3A8AA725.7446DEA0@ubishops.ca> <20010214165758.L28359@e-trend.de> <20010214122244.H7859@conectiva.com.br> <3A99986F.1AC6A46F@yahoo.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Hood wrote:

> On my ThinkPad 600, The ThinkPad PnP BIOS configures
> all PnP devices at boot time.
>
> If I load the isa-pnp.o driver it never detects any ISA PnP
> devices: it says "isapnp: No Plug & Play device found".  This
> is unfortunate, because it means that device drivers can't
> find out from isa-pnp where the devices are.
>
> David Hinds's pcmcia-cs package contains driver code that
> interfaces with the PnP BIOS.  With it, one can list the resource
> usage of ISA PnP devices (serial and parallel ports, sound chip,
> etc.) and set them, using the "lspnp" and "setpnp" commands.
>
> Would it not be useful if the isa-pnp driver would fall back
> to utilizing the PnP BIOS (if possible) in order to read and

I would find this EXTREMELY usefull... my Compaq laptop's
hot-dock with power eject will only work if Linux uses
PnP BIOS's insert/eject methods.

I saw some code in early 2.3 that would talk to bios, i still have
a tarball, but it seems 2.4 only does hardware banging (best in
*most* cases...)

>
> change ISA PnP device configurations when it can't do this
> itself?  If so, could this perhaps be done by bringing the Hinds
> PnP BIOS driver into the kernel and interfacing isa-pnp to it?

