Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262157AbSJNUBn>; Mon, 14 Oct 2002 16:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262156AbSJNUBa>; Mon, 14 Oct 2002 16:01:30 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:56337 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262154AbSJNUAz>; Mon, 14 Oct 2002 16:00:55 -0400
Message-ID: <3DAB23CB.5B52ECF1@linux-m68k.org>
Date: Mon, 14 Oct 2002 22:06:35 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kbuild-devel <kbuild-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: linux kernel conf 0.9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At http://www.xs4all.nl/~zippel/lc/ you can find as usual the latest
version of the new config system.
I still haven't got a single mail from someone who tried it and didn't
like it, what makes me a bit nervous :), so if you think something must
be wrong, now is your last chance. Next version will go to Linus.
Changes:
- as alternative suggestion for the config name I used "Kconfig" this
time. I tried "Config", but somehow that's terrible to do find for, as
one gets to many false positives. Even with a capital 'C' there are
still these:
Documentation/networking/Configurable
scripts/Configure
(ok, the latter will go away :) ).
- kbuild fixes (many thanks to Sam Ravnborg), I only added the clean
targets.
- the back end is now generated as shared library and loaded by qconf at
run time.
- small syntax change: "depends on", "requires" is also accepted besides
"depends", generated is "depends on".
- conf displays the help text again.
- the behaviour difference in qconf between qt2 and qt3, when all
symbols are shown, is fixed.

bye, Roman
