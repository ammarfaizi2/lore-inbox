Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262661AbSI1AtE>; Fri, 27 Sep 2002 20:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbSI1AtE>; Fri, 27 Sep 2002 20:49:04 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:3728 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S262661AbSI1AtC>;
	Fri, 27 Sep 2002 20:49:02 -0400
Date: Fri, 27 Sep 2002 19:54:16 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
cc: Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jordan Breeding <jordan.breeding@attbi.com>,
       Matthew Wilcox <willy@debian.org>, Robert Love <rml@tech9.net>,
       Mikael Pettersson <mikpe@csd.uu.se>, Andrew Morton <akpm@digeo.com>
Subject: 2.5 Kernel Problem Reports as of 27 Sep
Message-ID: <Pine.LNX.4.44.0209271833280.12092-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This report can be accessed at 
http://members.cox.net/tmolina/kernprobs/020927-status.html

The latest update can always be accessed at
http://members.cox.net/tmolina/kernprobs/status.html

I've changed the format somewhat for posting to lkml based on feedback and 
included comments and references.  I'm also cc'ing those mentioned 
requesting feedback.  Please let me know if this works.

  Problem Title                          Status             Discussion

   1. http://marc.theaimsgroup.com/?l=linux-kernel&m=103166646702935&w=2
   BUG at kernel/sched.c                  closed             15 Sep 2002

   2. http://marc.theaimsgroup.com/?l=linux-kernel&m=103184045102066&w=2
                                          closed             13 Sep 2002

   3. http://marc.theaimsgroup.com/?l=linux-kernel&m=103220232808356&w=2
                                          closed             18 Sep 2002
------------------------------------------------------------------------
   4. http://marc.theaimsgroup.com/?l=linux-kernel&m=103170969316930&w=2
   lockups under X                        open               21 Sep 2002

   5. http://marc.theaimsgroup.com/?l=linux-kernel&m=103237870212293&w=2
                                          additional reports 18 Sep 2002
------------------------------------------------------------------------
   6. http://marc.theaimsgroup.com/?l=linux-kernel&m=103260318814826&w=2
   2.5.37 won't run X                     closed             23 Sep 2002
------------------------------------------------------------------------
   7. http://marc.theaimsgroup.com/?l=linux-kernel&m=103170969316930&w=2
   mouse locks up X                       open               11 Sep 2002

   8. http://marc.theaimsgroup.com/?l=linux-kernel&m=103274064128049&w=2
                                          additional reports 23 Sep 2002

   9. http://marc.theaimsgroup.com/?l=linux-kernel&m=103170259412602&w=2
   KVM/Mouse problem                      open               20 Sep 2002

  10. http://marc.theaimsgroup.com/?l=linux-kernel&m=103299680529254&w=2
   Mouse/keyboard problems                open               27 Sep 2002

Are any of the above problems related?  At least the last one appears to 
be related to the recent input layer changes.
------------------------------------------------------------------------
  11. http://marc.theaimsgroup.com/?l=linux-kernel&m=103250741229189&w=2
   AIC7XXX boot failure                   open               20 Sep 2002

This was reported by Lukasz Trabinski <lukasz@wsisiz.edu.pl>, but never 
responded to, and was never followed up. Should this be kept open?  
------------------------------------------------------------------------
  12. http://marc.theaimsgroup.com/?l=linux-kernel&m=103238248416900&w=2
   Dead loop on virtual device lo         open               18 Sep 2002

This was reported by Marc-Christian Petersen <m.c.p@wolk-project.de>, but 
never responded to, and was never followed up.  Should this be kept open?
------------------------------------------------------------------------

  13. http://marc.theaimsgroup.com/?l=linux-kernel&m=103241914811779&w=2
   nmi_watchdog problem                   open               19 Sep 2002

This was reported by Jordan Breeding <jordan.breeding@attbi.com>, but 
never responded to, and was never followed up.  Should this be kept open?
------------------------------------------------------------------------
  14. http://marc.theaimsgroup.com/?l=linux-kernel&m=103236777430692&w=2
   JFS software suspend problem           possible fix in bk 18 Sep 2002

  15. http://marc.theaimsgroup.com/?l=linux-kernel&m=103255645120076&w=2
   preempt related lockup                 closed             21 Sep 2002
------------------------------------------------------------------------
  16. http://marc.theaimsgroup.com/?l=linux-kernel&m=103238121815285&w=2
   DRM/XFree issue                        open               18 Sep 2002

This was reported by Marc-Christian Petersen <m.c.p@wolk-project.de>, but 
never responded to, and was never followed up.  Should this be kept open?
-------------------------------------------------------------------------
  17. http://marc.theaimsgroup.com/?l=linux-kernel&m=103237662509801&w=2
   oops in lock_get_status                open               18 Sep 2002

  18. http://marc.theaimsgroup.com/?l=linux-kernel&m=103244657605155&w=2
                                          additional reports 20 Sep 2002

Matthew Wilcox <willy@debian.org> requested debugging data and was working 
on a fix.  What is the status of this?
--------------------------------------------------------------------------
  19. http://marc.theaimsgroup.com/?l=linux-kernel&m=103270005902896&w=2
   scheduling while atomic oops           open               22 Sep 2002

  20. http://marc.theaimsgroup.com/?l=linux-kernel&m=103298586617966&w=2
                                          another report     25 Sep 2002

Robert Love <rml@tech9.net> says this is known, won't hurt anything, but 
needs fixed.  Should this be kept open?
------------------------------------------------------------------------
  21. http://marc.theaimsgroup.com/?l=linux-kernel&m=103264945210526&w=2
   broken floppy driver                   open               23 Sep 2002

I was able to duplicate the broken behaviour prior to 2.5.39 but haven't 
been able to test the latest bk revision.  I will test it further this 
weekend.
------------------------------------------------------------------------
  22. http://marc.theaimsgroup.com/?l=linux-kernel&m=103269067030835&w=2
   IDE oopses on vmware                   closed             23 Sep 2002

  23. http://marc.theaimsgroup.com/?l=linux-kernel&m=103267794124788&w=2
   ide-scsi problem                       open               22 Sep 2002
------------------------------------------------------------------------
  24. http://marc.theaimsgroup.com/?l=linux-kernel&m=103277899317468&w=2
   IDE problems on prePCI                 open               23 Sep 2002

This was reported by Mikael Pettersson <mikpe@csd.uu.se>, but never 
responded to, and never followed up.  Should this be kept open?
------------------------------------------------------------------------
  25. http://marc.theaimsgroup.com/?l=linux-kernel&m=103242818519195&w=2
   ide double init                        open               19 Sep 2002

Several developers seem to have an idea where the breakage may be, but an 
update hasn't been posted.  What is the status?
------------------------------------------------------------------------
  26. http://marc.theaimsgroup.com/?l=linux-kernel&m=103281667726673&w=2
   modular IDE broken                     open               24 Sep 2002

Alan Cox rightly points out that fixing modular IDE should wait until IDE 
support has been cleaned up and works reliably.  I haven't been able to 
break IDE since the "new" IDE layer was implemented.  I'm inclined to keep 
this around unless there is an objection.
------------------------------------------------------------------------

  27. http://marc.theaimsgroup.com/?l=linux-kernel&m=103278825525479&w=2
   Oops in 2.5.38-mm2                     open               23 Sep 2002

Andrew Morton <akpm@digeo.com> says this is not an oops, it's a warning.  
Should this be kept open?
------------------------------------------------------------------------
  28. http://marc.theaimsgroup.com/?l=linux-kernel&m=103282505101823&w=2
   oops in vsnprintf (2.5-bk)             open               23 Sep 2002

  29. http://marc.theaimsgroup.com/?l=linux-kernel&m=103055061028368&w=2
   loadlin boot failure                   open               27 Sep 2002

  30. http://marc.theaimsgroup.com/?l=linux-kernel&m=103282695403237&w=2
   semaphore.c calls sleeping function    open               23 Sep 2002

  31. http://marc.theaimsgroup.com/?l=linux-kernel&m=103296031616858&w=2
   2.5.38-mm2 aha152x module fails        open               25 Sep 2002

  32. http://marc.theaimsgroup.com/?l=linux-kernel&m=103296919327682&w=2
   oops with kernel LLC                   open               25 Sep 2002

  33. http://marc.theaimsgroup.com/?l=linux-kernel&m=103315199307542&w=2
   loop trying to go beyond end of device open               27 Sep 2002


