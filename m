Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266965AbSL3Mx3>; Mon, 30 Dec 2002 07:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266964AbSL3Mx3>; Mon, 30 Dec 2002 07:53:29 -0500
Received: from pusa.informat.uv.es ([147.156.10.98]:25232 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP
	id <S266958AbSL3Mx2>; Mon, 30 Dec 2002 07:53:28 -0500
Date: Mon, 30 Dec 2002 14:01:48 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: How much we can trust packet timestamping
Message-ID: <20021230130148.GB1591@pusa.informat.uv.es>
References: <20021230112838.GA928@pusa.informat.uv.es> <1041253743.13097.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1041253743.13097.3.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
From: uaca@alumni.uv.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2002 at 01:09:03PM +0000, Alan Cox wrote:
> On Mon, 2002-12-30 at 11:28, uaca@alumni.uv.es wrote:
> > Hi all
> > 
> > IMHO The problem is quite complicated because
> > 
> > + common hardware is not designed for real time:
> > 
> > 	- sends multiple PDUs within one interrupt, and can be delayed
> > 	- Host adapter bus & infraestructure is not designed to garantee latency
> >   	etc...
> 
> The packet can be timestamped by the hardware receiving as well as by
> the kernel netif_rx code. This is actually intentional and there is
> hardware that supports doing IRQ raise time sampling which the driver
> can then use to get very accurate data.

Thanks Alan

Anybody know about a Linux driver that supports doing IRQ raise time
sampling? any doc/pointer/suggestion would be greatly appreciated

Thanks in advance

	Ulisses
                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---
 
