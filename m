Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281885AbRKWET1>; Thu, 22 Nov 2001 23:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281886AbRKWETR>; Thu, 22 Nov 2001 23:19:17 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:56817 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281885AbRKWETI>;
	Thu, 22 Nov 2001 23:19:08 -0500
Date: Thu, 22 Nov 2001 21:18:27 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "Garst R. Reese" <reese@isn.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: e2fsck-1.25 problem
Message-ID: <20011122211827.T1308@lynx.no>
Mail-Followup-To: "Garst R. Reese" <reese@isn.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3BFDBB15.AD778DA4@isn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3BFDBB15.AD778DA4@isn.net>; from reese@isn.net on Thu, Nov 22, 2001 at 10:57:25PM -0400
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 22, 2001  22:57 -0400, Garst R. Reese wrote:
> I got the latest, 1.25 and installed it before booting 2.4.15pre6.
> make check said all was fine. But, when I rebooted some messages sailed
> by about not being able to load shared libraries and libgcc_s.so.1 and
> fsck said something about errors in the fs and REBOOT NOW. Very scary
> always.

I take it you did a normal ./configure; make; make install?  I am running
1.25 without any problems.

> I booted up a recovery disk and ran e2fsck-1.10 on both of the relevant
> devices and with -f and all was well. I rebooted back to 2.4.14 and got
> the same messages flying by. Nothing of the sort in dmesg or the logs.

e2fsck wouldn't log anything in dmesg or in syslog.  It would be helpful
to see what the exact messages are.  Note also, that e2fsck 1.10 is
_very_ old (released 4.5 years ago), so it is entirely possible that
your fs has problems in it that it could not detect, but the newer e2fsck
does find.

I would suggest booting from a recovery disk with a statically linked
e2fsck 1.25, and then run it under "script" so you get a log of all
the output.  Post it here.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

