Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312419AbSDNTHK>; Sun, 14 Apr 2002 15:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312420AbSDNTHJ>; Sun, 14 Apr 2002 15:07:09 -0400
Received: from inje.iskon.hr ([213.191.128.16]:12995 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S312419AbSDNTHI>;
	Sun, 14 Apr 2002 15:07:08 -0400
To: Don Dupuis <ddupuissprint@earthlink.net>
Cc: linux-kernel@vger.kernel.org, "Stephen C. Tweedie" <sct@redhat.com>,
        Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: sard/iostat disk I/O statistics/accounting for 2.5.8-pre3
In-Reply-To: <dnu1qia3zg.fsf@magla.zg.iskon.hr>
	<1018578201.4395.22.camel@linux-ath.linux.dev.com>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Sun, 14 Apr 2002 21:06:44 +0200
Message-ID: <dnit6um75n.fsf@magla.zg.iskon.hr>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Common Lisp,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don Dupuis <ddupuissprint@earthlink.net> writes:

> I have a program called cspm at http://sourceforge.net/projects/cspm
> that uses Stephen's sard patches.  This program allows showing stats on
> all disks, controllers, and on a systemwide basis.  It will show ios,
> uses, merges, and blocks per second.  This program was written in QT.
> Please have a look at it and provide some feedback.
>

After having lots of problems with Qt 3.0, I finally managed to
install it on my Debian. Then I had to correct one bug in your source
to get it to compile, and now it just coredumps like it has a problem
when parsing /proc/partitions (as open() of that file is last thing
before it dies with segmentation fault).

I would like to try it, but didn't have much luck so far.
-- 
Zlatko
