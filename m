Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVEOOKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVEOOKZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 10:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVEOOKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 10:10:24 -0400
Received: from smtpout03-04.mesa1.secureserver.net ([64.202.165.74]:15291 "HELO
	smtpout03-04.mesa1.secureserver.net") by vger.kernel.org with SMTP
	id S261657AbVEOOJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 10:09:52 -0400
Message-ID: <428757F7.1030700@coyotegulch.com>
Date: Sun, 15 May 2005 10:08:55 -0400
From: Scott Robert Ladd <lkml@coyotegulch.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050512)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: Valdis.Kletnieks@vt.edu, Borislav Petkov <petkov@uni-muenster.de>,
       Edgar Toernig <froese@gmx.de>, jmerkey <jmerkey@utah-nac.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Automatic .config generation
References: <200505150742.j4F7gds1020180@turing-police.cc.vt.edu> <Pine.LNX.4.62.0505151148220.2387@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0505151148220.2387@dragon.hyggekrogen.localhost>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> Where's the harm in just building all the sound 
> modules - you only load one in the end anyway, and the space taken by the 
> other modules is negligible with the disk sizes of today I'd say (ok, 
> there's some extra build time involved, but that shouldn't be a big deal 
> either).

A desktop computer with a large hard drive may be the norm for kernel
developers, but it isn't (by far) the only environment where the kernel
is built. Embedded devices, small systems, older hardware, and
heterogenous networks all require a bit more finesse than a simple
"build it all and throw the mess at the hardware" approach.

The complexity of the kernel is growing, making it more difficult for
people to understand what they need and how to get it. It seems to me
that a computer can analyze itself to determine the "best" build
options. That's part of the reasoning behind my Acovea technology --
reducing complexity through smarter software.

    http://www.coyotegulch.com/products/acovea

Acovea isn't directly applicable to the kernel, but the idea of the
computer performing self-discovery is certainly valid. Once I get
another project finished, I'm going to take a more formal look at kernel
configuration, and see what might be done.

..Scott
