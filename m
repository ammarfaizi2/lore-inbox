Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289982AbSBFDUl>; Tue, 5 Feb 2002 22:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289987AbSBFDUb>; Tue, 5 Feb 2002 22:20:31 -0500
Received: from cvg-65-27-175-98.cinci.rr.com ([65.27.175.98]:5367 "EHLO
	velma.lathi.net") by vger.kernel.org with ESMTP id <S289982AbSBFDUZ>;
	Tue, 5 Feb 2002 22:20:25 -0500
To: linux-kernel@vger.kernel.org
Subject: Intel Speedstep bug in 2.4.17?
X-Url: http://www.lathi.net
X-Face: +GT&`y}rSVHq>&PvSIvtsy^RC6Agyxq)t+25D#'iTroOnA/'pcE$QD*WU1=WLS*OC\0y-kS
 |k+)w~x<On+~nkw**|X{sAHBiS2:_=w#<!?;UWm4|C05osQ8`jpRF+[o!wRPjV`tiTN~i'XXwZz3w=
 7|j)RyEq{~2v;Ht<;!)b'Ni[A{&xm,Myo6+w+#e
Reply-To: lathi@seapine.com
From: Doug Alcorn <lathi@seapine.com>
Date: 05 Feb 2002 22:19:33 -0500
Message-ID: <87eljzb8l6.fsf@localhost.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (asparagus)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an IBM Thinkpad A22m with an Intel Pentium III (Coppermine)
800Mhz.  I custom compiled a 2.4.17 kernel.  I'm also using Sawfish
1.0.1-6.  I have a problem with the mouse input in my XFree86 4.1.0.
Sometimes it doesn't register mouse clicks (requiring me to click
three or four times).  Also, the focus follows mouse seems off.
Most times I have to move the mouse in and out of a window several
times before the focus actually switches.  I originally thought this
was a bug in sawfish, so I asked there.  They said it was actually a
kernel issue.  I'm not sure I really understand that; however, when I
boot the machine with the AC plugged in I never see these symptoms.
If I boot the machine on battery power the symptoms show up right
away.  Also, if I boot on AC but later suspend and then resume on
battery power I don't see any of the symptoms.  Can anyone shed any
light on this?  Is it a known issue?  Is it fixable?

Here are my APM configuration variables for my kernel:

CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y
CONFIG_APM_ALLOW_INTS=y
# CONFIG_APM_REAL_MODE_POWER_OFF is not set
# CONFIG_ACPI is not set

-- 
 (__) Doug Alcorn (mailto:doug@lathi.net http://www.lathi.net)
 oo / PGP 02B3 1E26 BCF2 9AAF 93F1  61D7 450C B264 3E63 D543
 |_/  If you're a capitalist and you have the best goods and they're
      free, you don't have to proselytize, you just have to wait. 
