Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284776AbSABVcO>; Wed, 2 Jan 2002 16:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287055AbSABVb7>; Wed, 2 Jan 2002 16:31:59 -0500
Received: from ns.suse.de ([213.95.15.193]:51208 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287044AbSABVbg>;
	Wed, 2 Jan 2002 16:31:36 -0500
Date: Wed, 2 Jan 2002 22:31:35 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020102161347.A16223@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0201022230240.427-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Eric S. Raymond wrote:

> I just downloaded and tested Arjan deVen's dmidecode.c program.
> That will do what I want, but it has the irritating problem that
> it requires root privileges for access to /dev/kmem.

Yup, needs to map BIOS tables.

> Is the DMI data available in /proc files anywhere?

Nope.

> If not, should it be?

Questionable. Dumping this in /proc just to make kernel autoconfig
easier seems dreadful overkill.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

