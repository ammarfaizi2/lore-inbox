Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbTLWQE6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 11:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbTLWQE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 11:04:57 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:31938 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S261744AbTLWQC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 11:02:57 -0500
Date: Tue, 23 Dec 2003 08:04:25 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: "Giacomo A. Catenazzi" <cate@pixelized.ch>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: SCO's infringing files list
Message-ID: <20031223160425.GB45620@gaz.sfgoth.com>
References: <1072125736.1286.170.camel@duergar> <200312221519.04677.tcfelker@mtco.com> <Pine.LNX.4.58.0312221337010.6868@home.osdl.org> <20031223002641.GD28269@pegasys.ws> <20031223092847.GA3169@deneb.enyo.de> <3FE811E3.6010708@debian.org> <Pine.LNX.4.58.0312230317450.12483@home.osdl.org> <3FE862E7.1@pixelized.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE862E7.1@pixelized.ch>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo A. Catenazzi wrote:
> I found only a mail in linux-activists: It say """
> 4. lots of stuffs added to errno.h and string/errlist.c.

Yeah, I just found that one too - its in digest485 from the tarball
http://www.ibiblio.org/pub/historic-linux/ftp-archives/tsx-11.mit.edu/Oct-07-1996/mail-archive/linux-activists/Volume2/Linux-V2-4XX.tar.z

| From: hlu@yoda.eecs.wsu.edu (H.J. Lu)
| Subject: Re: gcc-2.2.2 patches for linux?
| Date: 19 Jul 92 15:42:48 GMT
|
[...]
| This is gcc 2.2.2 for Linux. It is on banjo.concert.net under
| /pub/Linux/GCC. Gcc 2.3 will support Linux, according to RMS. The FSF
| has all the files Linux needs.

Note that this is back when gcc and libc were distributed together, both
by H J Lu.  The file list in the announcement includes:

| 1. 2.2.2db.tar.Z (cpp, libg.a and libc_p.a)
| 2. 2.2.2lib.tar.Z (cc1, cc1plus)
| 3. 2.2.2misc.tar.Z (header files, drivers, libs, doc, ....)
| 4. shlib-2.2.2.tar.Z (making the shared libs for gcc 2.2.2)
| 5. libc-2.2.2.tar.Z (source code for the libs)
| 6. gcc-2.2.2.tar.Z (patches for compiling gcc 2.2.2)
| 7. 0.96bp2inc.tar.Z (the kernel header files for 0.96b patch level 2)

The last file seems to be a modified version of the 0.96bp2 header files
needed in order to work with the new gcc release (searching for that filename
turns up a message discussing it a little)  So I'm guessing that the
July 25, 1992 errno.h in the linux tree is a merge from this code.

Now, does anyone have a copy of "0.96bp2inc.tar.Z" lying around?

-Mitch
