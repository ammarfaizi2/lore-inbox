Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280814AbRLGNah>; Fri, 7 Dec 2001 08:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281009AbRLGNa2>; Fri, 7 Dec 2001 08:30:28 -0500
Received: from web13905.mail.yahoo.com ([216.136.175.68]:31753 "HELO
	web13905.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S280814AbRLGNaU>; Fri, 7 Dec 2001 08:30:20 -0500
Message-ID: <20011207133020.41163.qmail@web13905.mail.yahoo.com>
Date: Fri, 7 Dec 2001 05:30:20 -0800 (PST)
From: Jorge Carminati <jcarminati@yahoo.com>
Subject: Re: Kernel freezing....
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Well, I have some news regarding my case. 

Brief for the impatient: IMHO it's a kernel bug.

7pm: I arrived home from work; as suggested by Alan I ran memtest86
(v.2.8). I let it make two passes as to have a first impression. NO
memory error was found. It took ~24 minutes for each pass (240 Mb total
(256Mb - 16Mb used for video card)). Meanwhile I was compiling in my
Mandrake workstation a kernel optimized for i386 as suggested by
François Cami.

7.50pm: I spent a couple of minutes repairing with fsck my ext3
partition; had a lot of freezes the previous day.

8pm: I ftped the kernel to the notebook (first attempt failed; kernel
froze again (Red Hat's default kernel) second attempt was ok). Rebooted
and logged in in init 1. I typed some commands, and later started X
Window, no freeze. Next I launched lot of applications, just to try a
very basic memory stress. I started to enjoy Linux in my notebook.
After an uptime of 1:40 hour I decided to switch to the next kernel
optimized version: i486.

9.40pm: Booted i486 kernel. Made some basic tests, played with XFree86,
while at the same time for first time I was compiling a newer kernel
using this notebook (using Red Hat's 7.2 default gcc, etc). This newer
kernel was optimized for 586/K5. Rebooted after an uptime of 30 min
without a freeze.

10:15pm: Played a lot with this new kernel for almost 1:30 hour, no
freeze suffered. 

Last thing I did was to compile again a newer kernel for the next cpu
type (I think it´s named "Pentium Standard" or something similar). I´ll
test probably on saturday this kernel as I went to sleep.

In all the cases the compiled kernel had set exactly the same options,
**just changed the cpu optimization type**. Kernel version 2.4.16.

I was thinking, as suggested by Alan, to ran memtest86 all night long,
but as didn't suffered in 4 hours a freeze, I discarded this idea.


Conclusion: IMHO it´s a kernel bug. The same .config optimized for AMD
freezes, and Red Hat's default kernel does the same. Luckily for my
investment it´s not a memory bug.

I'll investigate when this bug is introduced playing with the cpu
optimization setting. I'll post my results probably next monday. 

If anyone has any kind of suggestion or want me to test something in
particular please let me know.

* PLEASE cc to jcarminati@yahoo.com for any answer. I'm not subscribed.
*

Kind regards and thanks again.
Jorge Carminati.
jcarminati@yahoo.com

__________________________________________________
Do You Yahoo!?
Send your FREE holiday greetings online!
http://greetings.yahoo.com
