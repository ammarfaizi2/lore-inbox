Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129107AbRBBNJ0>; Fri, 2 Feb 2001 08:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129349AbRBBNJQ>; Fri, 2 Feb 2001 08:09:16 -0500
Received: from charybda.fi.muni.cz ([147.251.48.214]:61445 "HELO
	charybda.fi.muni.cz") by vger.kernel.org with SMTP
	id <S129107AbRBBNJE>; Fri, 2 Feb 2001 08:09:04 -0500
From: Jan Kasprzak <kas@informatics.muni.cz>
Date: Fri, 2 Feb 2001 14:09:00 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink related)
Message-ID: <20010202140900.B6082@informatics.muni.cz>
In-Reply-To: <20010202131623.A6082@informatics.muni.cz> <E14OfPx-0006Pq-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14OfPx-0006Pq-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Feb 02, 2001 at 12:34:19PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
: > Hans Reiser wrote:
: >: This is why our next patch will detect the use of gcc 2.96, and complain, in the
: >: reiserfs Makefile.
: >: 
: > 	OK, thanks. It works with older compiler (altough I use gcc 2.96
: > for a long time for compiling various 2.[34] kernels without problem).
: 
: Ok which 2.96 compiler do you have. I need to get this one chased down since
: its probably also going to be in the current gcc CVS branches heading for 3.0
: 
: 2.96-69 should be ok (thats the one I've been using without trouble). The 
: original one with RH 7.0 off the CD does miscompile a few kernel things.

	It is the original one. I'll try with the -69:

$ rpm -q gcc
gcc -gcc-2.96-54
$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.0)

-Yenya

-- 
\ Jan "Yenya" Kasprzak <kas at fi.muni.cz>       http://www.fi.muni.cz/~kas/
\\ PGP: finger kas at aisa.fi.muni.cz   0D99A7FB206605D7 8B35FCDE05B18A5E //
\\\             Czech Linux Homepage:  http://www.linux.cz/              ///
> Is there anything else I can contribute? -- The latitude and longtitude of
the bios writers current position, and a ballistic missile.       (Alan Cox)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
