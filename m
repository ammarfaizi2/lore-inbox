Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266871AbUHITAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266871AbUHITAW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 15:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266902AbUHIS7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:59:50 -0400
Received: from the-village.bc.nu ([81.2.110.252]:54218 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266871AbUHIS5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:57:40 -0400
Subject: Re: dynamic /dev security hole?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Eric Lammerts <eric@lammerts.org>
Cc: Marc Ballarin <Ballarin.Marc@gmx.de>, Greg KH <greg@kroah.com>,
       albert@users.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0408091238080.8693@vivaldi.madbase.net>
References: <20040808162115.GA7597@kroah.com>
	 <1091969260.5759.125.camel@cube>
	 <20040808175834.59758fc0.Ballarin.Marc@gmx.de>
	 <20040808162115.GA7597@kroah.com>
	 <20040809000727.1eaf917b.Ballarin.Marc@gmx.de>
	 <Pine.LNX.4.58.0408090025590.26834@vivaldi.madbase.net>
	 <1092062974.14153.26.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0408091203160.8353@vivaldi.madbase.net>
	 <1092065586.14144.31.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0408091238080.8693@vivaldi.madbase.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092074088.14568.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 09 Aug 2004 18:54:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-09 at 17:47, Eric Lammerts wrote:
> > I have linked copy (not open)
> > Device unloaded
> 
> At this point, udev (with the chown/chmod patch) would chown your
> linked copy (before unlinking the original device node), right?

Providing it does so its safe I think yes

Well apart from stupid things like udev on shared NFS filestore, but 
anyone doing that probably deserves it..

