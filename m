Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291942AbSBYBH7>; Sun, 24 Feb 2002 20:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291934AbSBYBHs>; Sun, 24 Feb 2002 20:07:48 -0500
Received: from jalon.able.es ([212.97.163.2]:43186 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S291927AbSBYBHd>;
	Sun, 24 Feb 2002 20:07:33 -0500
Date: Mon, 25 Feb 2002 02:07:25 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Randy Hron <rwhron@earthlink.net>
Subject: [PATCHSET] Linux 2.4.18-rc4-jam2
Message-ID: <20020225020725.A1674@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, lkml readers.

After one other session of patch messing, here is rc4-jam2. Main update
is vm-25 -> vm-27 from Andrea. Get it as usual at:

http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.18-rc4-jam2/

and as not so usual at:

http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.18-rc4-jam2.tar.gz

I have reordered the patches to make easier to test cleanly subsystems:
- 0* is VM update. It applies cleanly (and after a compiler.h addendum,
  builds cleanly) on 18-rc4, for people that only want to test AA-vm
  vs RMAP-vm (hint, hint...)
- 1* are tiny smp enhancements, that I think are safe.
- 2* are O1 scheduler and low-latency
- 3* are SCSI-IDE updates.
- 5* mixed things...
- 6* sensors
- 7* bproc
- 8* miscelanea

Fore serious tests, I would not apply anything >=50, unless you are
interested on something there.

Good luck. My box lives (see signature).

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-rc4-jam2 #1 SMP Mon Feb 25 01:28:24 CET 2002 i686
