Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWHQNL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWHQNL6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWHQNL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:11:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:51137 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932477AbWHQNL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:11:57 -0400
Subject: Re: PATCH: Multiprobe sanitizer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1155819861.4494.61.camel@laptopd505.fenrus.org>
References: <1155746538.24077.371.camel@localhost.localdomain>
	 <20060816222633.GA6829@kroah.com>
	 <1155774994.15195.12.camel@localhost.localdomain>
	 <1155797833.11312.160.camel@localhost.localdomain>
	 <1155804060.15195.30.camel@localhost.localdomain>
	 <1155806676.11312.175.camel@localhost.localdomain>
	 <20060817120013.GC6843@kroah.com>
	 <1155816777.11312.177.camel@localhost.localdomain>
	 <20060817122244.GA17956@kroah.com>
	 <1155818250.11312.181.camel@localhost.localdomain>
	 <1155819861.4494.61.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 15:10:09 +0200
Message-Id: <1155820210.11312.184.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 15:04 +0200, Arjan van de Ven wrote:

> > udev will not create stable names for a bunch of things... at least not
> > with the default config that comes with distros. On my shuttle with the
> > built-in USB card reader, whatever config comes up with the box will
> > cause the machine to boot or fail to boot due to sda not beeing what
> > it's expected to be, and udev is of no help because it won't create
> > stable device names. 
> 
> that's what mount by label is for though..
> 
> (which isn't a udev but a distro thing)

I know and that's what I use, but it wasn't standard on my distro
(debian, ok, my fault...) and the problem is still there for pretty much
any other class of device in the system... (and mount by label isn't a
udev thing.. won't fix anything but mountable devices which is fairly
limitative, no help with usb vs. firewire vs. ata cd-writers etc....
udev can do it but isn't configured to do so by default on distros)

Ben.


