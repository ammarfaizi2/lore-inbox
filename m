Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129509AbRCLFi4>; Mon, 12 Mar 2001 00:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129511AbRCLFir>; Mon, 12 Mar 2001 00:38:47 -0500
Received: from smarty.smart.net ([207.176.80.102]:55813 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S129509AbRCLFio>;
	Mon, 12 Mar 2001 00:38:44 -0500
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200103120539.AAA04151@smarty.smart.net>
Subject: Re: linux localization
To: linux-kernel@vger.kernel.org
Date: Mon, 12 Mar 2001 00:39:51 -0500 (EST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> My work will concern with the internationalization of Linux
>> So, could anybody tell me what kinds of features should be in the
>> consideration when linux be localized from english to Japanese or
chinese,
>> say using 2 bytes character set.
>
>Most of the Linux userspace libraries are set up for handling UTF8 and
>other internationalisations. Fonts are more of an issue and lack of
application>translations. Filenames are defined to be UTF8.

For the features that don't exist in Linux yet, you want to look closely
at Plan 9 From Bell Labs, whence UTF-8 originates. Plan 9 for example has
font cacheing in the kernel for huge glyph sets, if I read it right. The
Plan 9 C compiler, written by Ken Thompson, author of UNIX and ed,
specifically for writing Plan 9, is fully UTF-8 also. Everything else in
Plan 9 is also UTF-8, from ed to libc to the GUI.

Per-process namespaces are a Plan 9 idea also. That is the ultimate in
localization. Plan 9 was released relatively recently under a license
clearly patterned after the GPL. Congratulations once again to Richard
Stallman. Thompson, Ritchie, Pike and so on have embraced his most
important ideas. 

Plan 9 has a narrow platform base compared to Linux or NetBSD. I myself
haven't been able to install it on my oldish hardware. You probably need
to see it running, I suspect. 

My own Dotted Standard File Hierarchy mechanism in cLIeNUX
(Linux/GNU/unix) may also be of interest. See my "/" below. That could
easily be Japanese, Mandarin, Hindi, etc.

ftp://linux01.gwdg.de/pub/cLIeNUX/descriptive/DSFH.html

Rick Hohensee
www.clienux.com

:; cLIeNUX /dev/tty3  00:12:08   /
:;d -d */
Linux//        dev//          help//         mounts//       suite//
boot//         device//       incoming//     owner//        temp//
command//      floppy//       log//          source//
configure//    guest//        lost+found//   subroutines//
:; cLIeNUX /dev/tty3  00:42:44   /
:;
