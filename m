Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287156AbSABWvo>; Wed, 2 Jan 2002 17:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287143AbSABWvZ>; Wed, 2 Jan 2002 17:51:25 -0500
Received: from ns.suse.de ([213.95.15.193]:30223 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287150AbSABWvS>;
	Wed, 2 Jan 2002 17:51:18 -0500
Date: Wed, 2 Jan 2002 23:51:17 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Lionel Bouton <Lionel.Bouton@free.fr>
Cc: <esr@thyrsus.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <3C338DCC.3020707@free.fr>
Message-ID: <Pine.LNX.4.33.0201022349200.427-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Lionel Bouton wrote:

> > But this is not a bad reason.  Allowing people to avoid running suid
> > programs is a *good* reason.
> Usually yes. But for a code that simply parses /dev/kmem content without
> taking args...
> Just took a quick look at dmidecode.c and auditing this code doesn't
> seem out of reach.

Exactly. And 90% of it can be ditched.

> What's the difference security-wise between running this code in kernel
> space and in a suid prog? Avoiding loading libraries?
> Frankly I don't see the point.

*shrug* about the same point as having a /proc/acpi/dsdt I'd guess.
(Which worked fine as a run-as-root program called acpidmp, but
 for some reason someone thought it'd be good to dump in /proc)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

