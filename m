Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315934AbSEGSo3>; Tue, 7 May 2002 14:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315937AbSEGSo2>; Tue, 7 May 2002 14:44:28 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:19395 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S315934AbSEGSo1>; Tue, 7 May 2002 14:44:27 -0400
Date: Tue, 7 May 2002 12:44:15 -0600
Message-Id: <200205071844.g47IiFR32553@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Patrick Mochel <mochel@osdl.org>
Cc: <benh@kernel.crashing.org>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <Pine.LNX.4.33.0205071053070.6307-100000@segfault.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel writes:
> Oh, and it's with a modern, clean filesystem, 1/5 the size of devfs. 

The size argument is not an issue. I've already said that devfs will
shrink a lot once I move tree management from my own code to the VFS.
At that point devfs will mostly be:
- an API
- a way fo supporting the devfsd protocol.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
