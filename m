Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315282AbSFIWuN>; Sun, 9 Jun 2002 18:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315285AbSFIWuN>; Sun, 9 Jun 2002 18:50:13 -0400
Received: from p50887BDF.dip.t-dialin.net ([80.136.123.223]:8150 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315282AbSFIWuM>; Sun, 9 Jun 2002 18:50:12 -0400
Date: Sun, 9 Jun 2002 16:49:54 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Nicholas Miell <nmiell@attbi.com>
cc: christoph@lameter.com, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Jan Pazdziora <adelton@informatics.muni.cz>,
        <linux-kernel@vger.kernel.org>, <adelton@fi.muni.cz>
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
In-Reply-To: <1023661800.1511.23.camel@entropy>
Message-ID: <Pine.LNX.4.44.0206091643120.8715-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9 Jun 2002, Nicholas Miell wrote:
> Note that there's nothing stopping you from unpacking the tarball in
> cygwin, with it's own (nicely contained, and not nearly as ugly) symlink
> hack.

That's a hack in the cygwin libc, isn't it? It's the lib which opens 
another file instead of the original, isn't it?

> Don't forget NTFS,

NTFS isn't known to be well writable. Remember the oopses! (Sorry, NTFS 
people, if I do you any wrong)

> SMBFS,

...requires the windows system to be up...

> ISO-9660,

...needs to be burned onto CD first...

> HPFS (if Windows still supports it...),

Not by default, I think.

> and plain old FAT.

...which looses long names, IIRC. That's not a choice of choice...

> There's also third-party support for NFS,

...which again requires the windows to be up and running...

> HFS,

...which also needs to be burned onto cd or stored somewhere else...

> VxFS and others.

...which needs to be put somewhere, too...

I think VFAT is really the only real flexible transport fs for 
linux->windows.

Regards,
Thunder
-- 
German attitude becoming        |	Thunder from the hill at ngforever
rightaway popular:		|
       "Get outa my way,  	|	free inhabitant not directly
    for I got a mobile phone!"	|	belonging anywhere

