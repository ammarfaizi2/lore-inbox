Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129683AbQL2Iy2>; Fri, 29 Dec 2000 03:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129730AbQL2IyS>; Fri, 29 Dec 2000 03:54:18 -0500
Received: from exit1.i-55.com ([204.27.97.1]:17345 "EHLO exit1.i-55.com")
	by vger.kernel.org with ESMTP id <S129683AbQL2IyG>;
	Fri, 29 Dec 2000 03:54:06 -0500
Message-ID: <3A4C48AB.59B58F04@mailhost.cs.rose-hulman.edu>
Date: Fri, 29 Dec 2000 02:17:47 -0600
From: Leslie Donaldson <donaldlf@hermes.cs.rose-hulman.edu>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test11 alpha)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx 2.4.0 test12 hang
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  Just a small followup here, I haven't had a chance to dig throught the
driver
yet, I did forward a copy to the aic7xxx maintainer, but no response
yet. However
if you are having problems on an intel platform that is good news. (Non
intel
platforms get blown off a lot sigh.) This weekend I will try to debug it
or at least
figure out something. My initial guess is to disable all command tag
queueing, 
  While I am in the code I also want to go digging around and see if I
can find a 
way to turn of the in memory buffering that Linux does for block devices
as this
would make my fscking a LOT shorter, (18 gigs is slow),
   But first I need to find my null modem serial cable. sigh. funnsies.

Leslie Donaldson


>          hi!
>
>          kernel: 2.4.0.test12
>          hardware: Adaptec AIC-7892 Ultra 160/m SCSI host adapter (19160)
>
>          problem: kernel hangs when using my cdrom with cdparanoia to read cdda data.
>          (i have nothing else on the bus for now.)
>
>          i'd like 2 provide more info, but after 2 *long* fsck ... (maybe tomorrow :-(
>
>          i've read about similar hangs on an alpha on this list (same kind of controller)
>          any solution there ...
>
>          Regards,
>                  Armin
-- 
/----------------------------\ Current Contractor: None
|    Leslie F. Donaldson     | Current Customer  : None
|    Computer Contractor     | Skills:
Unix/OS9/VMS/Linux/SUN-OS/C/C++/assembly
| Have Computer will travel. | WWW  :
http://www.cs.rose-hulman.edu/~donaldlf
\----------------------------/ Email: mail://donaldlf@cs.rose-hulman.edu
Goth Code V1.1: GoCS$$ TYg(T6,T9) B11Bk!^1 C6b-- P0(1,7) M+ a24 n---
b++:+
                H6'11" g m---- w+ r+++ D--~!% h+ s10 k+++ R-- Ssw
LusCA++
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
