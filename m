Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291466AbSBAAri>; Thu, 31 Jan 2002 19:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291465AbSBAArW>; Thu, 31 Jan 2002 19:47:22 -0500
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:23663 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S291464AbSBAArH>; Thu, 31 Jan 2002 19:47:07 -0500
Date: Fri, 1 Feb 2002 01:46:59 +0100 (CET)
From: Simon Richter <Simon.Richter@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>
cc: James Simmons <jsimmons@transvirtual.com>,
        <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] amiga input api drivers
In-Reply-To: <3C59DCC4.EA3848E@linux-m68k.org>
Message-Id: <Pine.LNX.4.33.0202010141100.14728-100000@phobos.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2002, Roman Zippel wrote:

> > > > +   scancode = scancode >> 1;       /* lowest bit is release bit */
> > > > +   down = scancode & 1;

> He's correct, the up/down event is received in the lsb bit, the other 7
> bits are the keycode.

Well, I'm also unsure you mean the LSB here -- The hardware manual says
that bit 7 indicates that the key had been released.

   Simon

-- 
GPG public key available from http://phobos.fs.tum.de/pgp/Simon.Richter.asc
 Fingerprint: DC26 EB8D 1F35 4F44 2934  7583 DBB6 F98D 9198 3292
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!

