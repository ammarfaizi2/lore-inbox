Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316672AbSEQUJ3>; Fri, 17 May 2002 16:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316681AbSEQUJ2>; Fri, 17 May 2002 16:09:28 -0400
Received: from ns.suse.de ([213.95.15.193]:7435 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S316672AbSEQUJ0>;
	Fri, 17 May 2002 16:09:26 -0400
Date: Fri, 17 May 2002 22:09:22 +0200
From: Dave Jones <davej@suse.de>
To: Wayne.Brown@altec.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
Message-ID: <20020517220922.M4712@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>, Wayne.Brown@altec.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <86256BBC.006D500D.00@smtpnotes.altec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 02:51:57PM -0500, Wayne.Brown@altec.com wrote:
 > Personally, I wish that the only changes anybody made were to the kernel itself
 > (new drivers added, existing performance improved, etc.) and that all the
 > supporting tools and utilities just could be left alone.  I know that's not
 > going to happen, but anything that slows down changes in those extraneous things
 > is fine with me.  I'd be perfectly happy if *years* from now I was compiling
 > Linux 45.10.12 with the same kbuild, CML, gcc and everything else that I'm using
 > right now.

Compare and contrast..

-rw-r--r--    1 davej    users     31426560 Jan  9  2001 linux-2.0.39.tar
-rw-r--r--    1 davej    users     85442560 Nov  6  2001 linux-2.2.20.tar
-rw-r--r--    1 davej    users    131727360 Feb 25 20:15 linux-2.4.18.tar
-rw-r--r--    1 davej    users    152524800 May 10 00:11 linux-2.5.15.tar

Spot the pattern? Exponential growth. not only that, but for the most
part, the build system is the same across all of these. If we continue
growing at the current rate without doing something about the build
process, we're all going to be needing 8-way Opterons with several
GB of memory to get any work done.

If kbuild2.5 is faster, and produces the same end result (or better
still, more accurate builds), there's no valid reason to ignore it
that I can see.

    Dave.
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
