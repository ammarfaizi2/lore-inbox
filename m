Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317378AbSFMFRp>; Thu, 13 Jun 2002 01:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317452AbSFMFRo>; Thu, 13 Jun 2002 01:17:44 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:37531 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317378AbSFMFRn>;
	Thu, 13 Jun 2002 01:17:43 -0400
Date: Thu, 13 Jun 2002 01:16:23 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Stevie O <stevie@qrpff.net>
cc: Francois Gouget <fgouget@free.fr>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
In-Reply-To: <5.1.0.14.2.20020613002633.00b1d488@whisper.qrpff.net>
Message-ID: <Pine.GSO.4.21.0206130114350.18281-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Jun 2002, Stevie O wrote:

> At 12:09 AM 6/13/2002 -0400, Alexander Viro wrote:
> >Vetoed.  Consider what happens if you rename such file, for one thing.
> 
> I don't understand
> What do you mean, if I rename such a file?

rename("foo.lnk", "foo");

or other way round.  Especially funny if you already have file opened.

