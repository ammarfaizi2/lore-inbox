Return-Path: <linux-kernel-owner+ralf=40uni-koblenz.de@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S315779AbSFPAx3>; Sat, 15 Jun 2002 20:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S315784AbSFPAx2>; Sat, 15 Jun 2002 20:53:28 -0400
Received: from norma.kjist.ac.kr ([203.237.41.18]:15311 "EHLO norma.kjist.ac.kr") by vger.kernel.org with ESMTP id <S315779AbSFPAx1>; Sat, 15 Jun 2002 20:53:27 -0400
Message-ID: <3D0BE1AC.3080202@nospam.com>
Date: Sun, 16 Jun 2002 09:54:04 +0900
From: Hugh <hugh@nospam.com>
User-Agent: Mozilla/5.0 (X11; U; Linux alpha; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: ko, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, coles@vip.kos.netDear
Subject: Re: Dual Athlon 2000 XP MP nightmare
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Steve, Richard, and others,

>I'm not sure that what I'm experiencing is a kernel problem, but I >thought
>I would stick my foot in the door nonetheless, since I have no real
>indication of what is going on.
>
>I have a dual Athlon 2000+ XP MP system. It's crashing very frequently >and
>looks to be getting worse. It seems to crash less with 2.4.19pre10-ac2
>which supports the 760 bus and 744x IDE controller, but with something
>that
>is as intermittent as this, who can tell?

I found three of us trying to use Athlon dual as a linux server so far.

>Machine specs:
>
> ASUS A7M266-D motherboard, 1006 BIOS rev.
> 2GB ECC registered memory
> 4 x 15K RPM Seagate UltraSCSI drives

So far the same.

> 2 x 2960 (AIC7892 rev 2) controllers
> 2 x 3C59x 3Com ethernet controllers
> !USB card to free up IRQs (removed later)
> 400W power supply

I also have a 400 watts.

> 240W power supply driving two of the hard drives + CD ROM
> Budget vid card
> 2 drives partitioned 30%/70%, 30% mirrored together for boot, 70%
>mirrored
>in RAID 0+1 with other drives

I got intemittent Memory-related errors while running Latex on a 1000
page book manuscript.
Without the error, the speed on this machine was the most impressive:

Athlon dual 1.6GHz : 16 sec
P4 Xeon dual 1.7GHz : 52 sec
P III single at 700 MHz : 35 sec

No error log in /var/log/message.  Very rarely but certainly the
Athlon dual crashed with the Reiserfs error (horrible!! I lost a file
of a chapter.  I recovered it only from a backup.)  Initially, I
thought that it is a kernel problem in the recent kernels.  In the
end, I realized that the kernel version really does not matter.  I
finally checked the memory one by one using memtest86 with the ECC
disabled in the CMOS setup.   No problem.  I then installed all four
memory modules and did memtest86.  Alas!!!!,  it found the memory error.
  Did the test three times.  All three times, it always stopped in the
middle with slightly different error messages, everytime reinstalled
the memory modules just to be sure about the contact.

That was when I returned the motherboard the second time.
The first time, the board gave me a CMOS error.   The third time, the
board even did not give me the first beep.  I now think that I should
have bought the Tyan board instead of the ASUS.

Regards,

G. Hugh Song





