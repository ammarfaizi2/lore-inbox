Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315119AbSFIUcH>; Sun, 9 Jun 2002 16:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315178AbSFIUcG>; Sun, 9 Jun 2002 16:32:06 -0400
Received: from [213.4.129.129] ([213.4.129.129]:19771 "EHLO tsmtp8.mail.isp")
	by vger.kernel.org with ESMTP id <S315119AbSFIUcG>;
	Sun, 9 Jun 2002 16:32:06 -0400
Date: Sun, 9 Jun 2002 22:05:37 +0200
From: Diego Calleja <diegocg@teleline.es>
To: Nicholas Miell <nmiell@attbi.com>
Cc: phillips@bonn-fries.net, adelton@informatics.muni.cz,
        christoph@lameter.com, linux-kernel@vger.kernel.org,
        adelton@fi.muni.cz
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
Message-Id: <20020609220537.6cd71662.diegocg@teleline.es>
In-Reply-To: <1023648813.1188.19.camel@entropy>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09 Jun 2002 11:53:32 -0700
Nicholas Miell <nmiell@attbi.com> escribió:

> First of all, some programs (WINE) will actually want to use the .lnk
> files, and transparently converting them to symlinks will complicate
> that.

I agree. M$ did .lnk _files_, but really, there's not symlinks in vfat
world. Even msdos doesn't recognize them. I don't remember if it's the
same in NTFS, W2000 & XP are so good that I can't work with them in 32MB
RAM...

And I must say that symlinks are not needed in most of the windows 9X
systems. They aren't really useful for most of the systems. But if
someone needs it, it'd be include as a .config option.....
