Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317189AbSFQXMp>; Mon, 17 Jun 2002 19:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317191AbSFQXMo>; Mon, 17 Jun 2002 19:12:44 -0400
Received: from inje.iskon.hr ([213.191.128.16]:54660 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S317189AbSFQXMn>;
	Mon, 17 Jun 2002 19:12:43 -0400
To: linux-kernel@vger.kernel.org
Cc: dalecki@evision-ventures.com
Subject: 2.5.22 IDE lockups
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Tue, 18 Jun 2002 01:12:38 +0200
Message-ID: <87elf5fqjd.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Doing heavy IDE transfer on a PDC 20269 IDE controller, kernel locks
up in a matter of seconds. As 2.5.21 was OK in that regard, I traced
the problem back through changesets and found that IDE 89 patch is the
culprit. All that is observed on SMP machine.
-- 
Zlatko
