Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbTLYMey (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 07:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264301AbTLYMey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 07:34:54 -0500
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:17415 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S264300AbTLYMew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 07:34:52 -0500
To: linux-kernel@vger.kernel.org
Subject: Laptop and CPU fan
Mail-Copies-To: nobody
From: kilobug@freesurf.fr (=?iso-8859-1?q?Ga=EBl_Le_Mignot?=)
Organization: HurdFr - http://hurdfr.org
X-PGP-Fingerprint: 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA
Date: Thu, 25 Dec 2003 13:34:36 +0100
Message-ID: <plopm3brpx3wkj.fsf@drizzt.kilobug.org>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello and merry X-mas !

I have  a problem with  teh CPU  fan of my  laptop, and it  seems very
weird to me. Basically,  when I boot Linux, if the CPU  fan was off at
boot time, it remains off forever (until the laptop turns off, and I'm
afraid  this would  damage it  one day).  If the  CPU fan  was  on, it
remains always on, using battery, but at least not damaging anything.

I tried to enable APM, ACPI, both of them, neither of them, it doesn't
change anything (with 2.4.21 and  2.6.0). ACPI doesn't not see the fan
(it sees CPU and AC adapter, but no battery nor fan).

I can disable PM at the BIOS level, and then the fan is always on, but
at full  power (if I  just wait  in grub until  the fan starts  at low
speed and boot  Linux, the fan stays at low  speed and everything goes
fine).

Then began two very weird things:

- if I boot a non-APM non-ACPI  kernel like GNU Mach, the fan is still
  controlled  by the  BIOS, and  everything goes  fine. This  does not
  happen if I  compile 2.6.0 with no APM nor ACPI  support. I tried to
  play with APM options like "enable  PM at boot time" too, it doesn't
  change anything.

- if I  boot a Debian kernel (kernel-image-2.4.21-5-686)  then the fan
  works well,  I tried  to recopy the  PM-related options  from Debian
  kernel to vanilla kernel, but then the fan doesn't work...

I'll try to find a newer BIOS  for my laptop, but if you have any clue
to help  me to  understand what's  happening, or any  trick to  use my
laptop as best as possible, I'ld be thankfull.

-- 
Gael Le Mignot "Kilobug" - kilobug@nerim.net - http://kilobug.free.fr
GSM         : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Fingerprint : 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA

Member of HurdFr: http://hurdfr.org - The GNU Hurd: http://hurd.gnu.org
