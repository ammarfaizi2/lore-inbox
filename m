Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262961AbTCKQAe>; Tue, 11 Mar 2003 11:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262962AbTCKQAe>; Tue, 11 Mar 2003 11:00:34 -0500
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:1178 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S262961AbTCKQAd>; Tue, 11 Mar 2003 11:00:33 -0500
From: Oliver Neukum <oliver@neukum.name>
To: Patrick Mochel <mochel@osdl.org>
Subject: Re: PCI driver module unload race?
Date: Tue, 11 Mar 2003 17:07:09 +0100
User-Agent: KMail/1.5
Cc: Greg KH <greg@kroah.com>, Roman Zippel <zippel@linux-m68k.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>
References: <Pine.LNX.4.33.0303110902010.1003-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0303110902010.1003-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303111707.09119.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This means the module refcount must remain at 0, even after it's bound to
> devices. Changing this would require a change in visible behavior, and
> require an extra step by a user to disconnect the driver before they
> unload the module.

Yes, that would mean changing behaviour. On the other hand, we require
new module utilities for 2.6 anyway, so why not?

	Regards
		Oliver

