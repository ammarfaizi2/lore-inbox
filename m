Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288003AbSABXk5>; Wed, 2 Jan 2002 18:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288016AbSABXj3>; Wed, 2 Jan 2002 18:39:29 -0500
Received: from ns.suse.de ([213.95.15.193]:49156 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288017AbSABXhz>;
	Wed, 2 Jan 2002 18:37:55 -0500
Date: Thu, 3 Jan 2002 00:37:53 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Lionel Bouton <Lionel.Bouton@free.fr>
Cc: <esr@thyrsus.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <3C3398E1.4080904@free.fr>
Message-ID: <Pine.LNX.4.33.0201030035230.5131-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Lionel Bouton wrote:

> > If /proc/dmi were to go in soon, at least I *could* rely on it in 2.6.
> If in rc.sysinit a call to "dmidecode > /var/run/dmi" were to go in the
> user space 2.6 kernel build dependancies in Documentation/Changes,
> you'll be on the same level.

Could even be done as part of Al's early-userspace, thus removing the
reliance upon vendors to do it.  Does imply that you're building 2.6 on a
2.6 enabled distro though.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

