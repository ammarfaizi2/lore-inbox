Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313328AbSDGOqL>; Sun, 7 Apr 2002 10:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313341AbSDGOqK>; Sun, 7 Apr 2002 10:46:10 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:33554 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S313328AbSDGOqK>; Sun, 7 Apr 2002 10:46:10 -0400
Message-ID: <3CB05CF8.4513BA83@linux-m68k.org>
Date: Sun, 07 Apr 2002 16:51:36 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.0 is available
In-Reply-To: <28682.1018189712@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Keith Owens wrote:

> >These 14 seconds (or 37 seconds on my machine) are always needed
> >whatever I try, e.g. "make foo/bar.o" also needs that time.
> 
> make NO_MAKEFILE_GEN=1 foo/bar.o.  Very low overhead for quick and
> dirty testing of changes, but if you want an accurate kernel build, you
> have to take the overhead.  kbuild 2.4 overhead for a full build when
> only minor changes have been made is even worse.

I don't want a kernel build, I just want a single object file to be
rebuilt?!
I can understand that it takes longer, when I change a Makefile or the
config, but why has the Makefile to be rebuilt, when only a source file
changed?

bye, Roman
