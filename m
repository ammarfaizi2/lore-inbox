Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267782AbTBGKWd>; Fri, 7 Feb 2003 05:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267783AbTBGKWd>; Fri, 7 Feb 2003 05:22:33 -0500
Received: from p0051.as-l043.contactel.cz ([194.108.242.51]:46841 "EHLO
	SnowWhite.janik.cz") by vger.kernel.org with ESMTP
	id <S267782AbTBGKWa> convert rfc822-to-8bit; Fri, 7 Feb 2003 05:22:30 -0500
To: sjralston1@netscape.net
Cc: Pam.Delaney@lsil.com
Cc: linux-kernel@vger.kernel.org
Subject: mptctl only as a module?
From: Pavel@Janik.cz (Pavel =?iso-8859-2?q?Jan=EDk?=)
X-Face: $"d&^B_IKlTHX!y2d,3;grhwjOBqOli]LV`6d]58%5'x/kBd7.MO&n3bJ@Zkf&RfBu|^qL+
 ?/Re{MpTqanXS2'~Qp'J2p^M7uM:zp[1Xq#{|C!*'&NvCC[9!|=>#qHqIhroq_S"MH8nSH+d^9*BF:
 iHiAs(t(~b#1.{w.d[=Z
Date: Fri, 07 Feb 2003 11:07:03 +0100
Message-ID: <m365rw9zg8.fsf@Janik.cz>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i386-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is there any reason to allow compilation of mptctl.o (CONFIG_FUSION_CTL)
only as a module?

drivers/message/fusion/Config.in:

  if [ "$CONFIG_MODULES" = "y" ]; then
    [...]
    dep_tristate "  Fusion MPT misc device (ioctl) driver" CONFIG_FUSION_CTL $CONFIG_FUSION m
  fi

I tried to compile it in and it works. I'd like to have static kernel
without modules, but need mptctl :-(
-- 
Pavel Janík

I'm glad that Emacs is bigger and more open than some of the people who use
it.
                  -- Tony Reed in gnu.emacs.help
