Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313326AbSDGOMx>; Sun, 7 Apr 2002 10:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313327AbSDGOMw>; Sun, 7 Apr 2002 10:12:52 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:46093 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S313326AbSDGOMw>; Sun, 7 Apr 2002 10:12:52 -0400
Message-ID: <3CB05524.4643C805@linux-m68k.org>
Date: Sun, 07 Apr 2002 16:18:12 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.0 is available
In-Reply-To: <7022.1018005968@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Keith Owens wrote:

> kbuild 2.5:
>   make -j8 oldconfig installable 8:51 (no make dep needed :)
>   make -j8 oldconfig installable  :14 (second run, no changes)

These 14 seconds (or 37 seconds on my machine) are always needed
whatever I try, e.g. "make foo/bar.o" also needs that time.
Some other problems:
"make foo/bar.[si]" doesn't work anymore.
"touch include/linux/mm.h" doesn't cause a recompile of any object.

bye, Roman
