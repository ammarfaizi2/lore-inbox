Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262402AbSJEQwi>; Sat, 5 Oct 2002 12:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262405AbSJEQwi>; Sat, 5 Oct 2002 12:52:38 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:11403 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S262402AbSJEQwe>;
	Sat, 5 Oct 2002 12:52:34 -0400
Date: Sat, 5 Oct 2002 11:57:59 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
cc: Stian Jordet <liste@jordet.nu>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Matthew Wilcox <willy@debian.org>, Burton Windle <bwindle@fint.org>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       <caligula@cam029208.student.utwente.nl>,
       Bill Davidsen <davidsen@tmr.com>,
       Stephen Marz <smarz@host187.south.iit.edu>,
       "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>,
       Bob_Tracy <rct@gherkin.frus.com>, Dominik Brodowski <linux@brodo.de>
Subject: 2.5 Problem Report Status
Message-ID: <Pine.LNX.4.44.0210050924470.10630-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following status report update can be found at:
http://members.cox.net/tmolina/kernprobs/021004-status.html

The latest update can be found at:
http://members.cox.net/tmolina/kernprobs/status.html


   Notes:
     * Items  marked  closed  or probable fix will be deleted after Linus
       issues the next patch version
     * Numerous  people  are reporting oops on boot in 2.5.39. It appears
       the problems are all caused by a bug in isapnp initialization. The
       fix is either to disable isapnp or patch in a workaround.

   Status                 Discussion  Problem Title
   open                   30 Sep 2002 KVM/Mouse problem
   1. http://marc.theaimsgroup.com/?l=linux-kernel&m=103299680529254&w=2

The problem was beeing investigated, but I never saw any reference to a 
fix being submitted to Linus.
-------------------------------------------------------------------------
   open                   20 Sep 2002 AIC7XXX boot failure
   2. http://marc.theaimsgroup.com/?l=linux-kernel&m=103356254615324&w=2

There have been problems reported off and on with this driver in 2.5.
------------------------------------------------------------------------- 
   open                   18 Sep 2002 Dead loop on virtual device lo
   3. http://marc.theaimsgroup.com/?l=linux-kernel&m=103238248416900&w=2

This was reported for 2.5.36, but I've not seen any followups nor 
reference to a fix.  There have been several updates to loop.c.  Does this 
problem still exist?  I'm ready to delete it from the list.
-------------------------------------------------------------------------
   open                   18 Sep 2002 DRM/XFree issue
   4. http://marc.theaimsgroup.com/?l=linux-kernel&m=103238121815285&w=2

This was reported for 2.5.36, but I've not seen any followups nor
reference to a fix.  There have been several updates referring to DRM.   
Does this problem still exist?  I'm getting ready to drop it from the 
list.
-------------------------------------------------------------------------
   open                   20 Sep 2002 oops in lock_get_status
   5. http://marc.theaimsgroup.com/?l=linux-kernel&m=103244657605155&w=2

This was being discussed, then data was requested by Matthew Wilcox 
<willy@debian.org> off-list.  I've seen no further followups.  What is the 
status of this?  I'm getting ready to drop it from the list.
-------------------------------------------------------------------------
   open                   04 Oct 2002 scheduling while atomic oops
   6. http://marc.theaimsgroup.com/?l=linux-kernel&m=103270005902896&w=2

This appears to be a long-running problem.  Is it related to the group of 
problems below involving "function might sleep while holding a lock" or is 
it a scheduling system problem?
-------------------------------------------------------------------------
   open                   30 Sep 2002 ide-scsi kernel panic
   7. http://marc.theaimsgroup.com/?l=linux-kernel&m=103336376827272&w=2

Several people have reported problems with ide-scsi either oopsing, 
locking up, or causing problems when being inserted or removed.  I have 
seen any reference to a fix for this one.
-------------------------------------------------------------------------
   open                   29 Sep 2002 IDE problems on prePCI
   8. http://marc.theaimsgroup.com/?l=linux-kernel&m=103277899317468&w=2

Mikael Pettersson <mikpe@csd.uu.se> reported this problem and proposed a 
patch.  Was the patch accepted, and did it fix the problem?
-------------------------------------------------------------------------
   open                   02 Oct 2002 modular IDE broken
   9. http://marc.theaimsgroup.com/?l=linux-kernel&m=103281667726673&w=2

Doctor, Doctor it hurts when I build ide modular.  Well don't do that 
then.  Alan Cox says this won't be fixed until all other problems with the 
ide system get fixed.
-------------------------------------------------------------------------
   fix available          02 Oct 2002 loadlin boot problem
  10. http://marc.theaimsgroup.com/?l=linux-kernel&m=103351848816172&w=2

I'm going to delete this one when Linus issues 2.5.41 unless someone 
objects.
-------------------------------------------------------------------------
   open                   25 Sep 2002 2.5.38-mm2 aha152x module fails
  11. http://marc.theaimsgroup.com/?l=linux-kernel&m=103296031616858&w=2

Is this specific to the mm tree or does the problem also exist in Linus' 
tree?  I've not seen reference to a fix.
-------------------------------------------------------------------------
   open                   27 Sep 2002 loop trying to go beyond end of
                                      device
  12. http://marc.theaimsgroup.com/?l=linux-kernel&m=103315199307542&w=2

This problem was reported for 2.5.38.  I've seen no updates, nor any 
reference to a fix.  Does the problem still exist in 2.5.40?
-------------------------------------------------------------------------
   open                   29 Sep 2002 USB Mass Storage Conflicts
  13. http://marc.theaimsgroup.com/?l=linux-kernel&m=103332858305678&w=2

Stephen Marz <smarz@host187.south.iit.edu> reported this problem for 
2.5.38.  I've not seen any followups, nor any reference to a fix.  Does 
the problem still exist?  
-------------------------------------------------------------------------
   open                   29 Sep 2002 Oracle 9.2 goes OOM on startup
  14. http://marc.theaimsgroup.com/?l=linux-kernel&m=103333545310595&w=2

This problem was reported for 2.5.39.  I have seen neither a followup, nor 
a reference to a fix.  Does this problem still exist in 2.5.40?
-------------------------------------------------------------------------
   open                   23 Sep 2002 oops in vsnprintf (2.5-bk)
  15. http://marc.theaimsgroup.com/?l=linux-kernel&m=103282505101823&w=2

More than one person has reported problems when doing a bk pull.  Is this 
a driver problem, or an application problem?
-------------------------------------------------------------------------
   open                   25 Sep 2002 oops with kernel LLC
  16. http://marc.theaimsgroup.com/?l=linux-kernel&m=103296919327682&w=2

   followups              29 Sep 2002
  17. http://marc.theaimsgroup.com/?l=linux-kernel&m=103334051214575&w=2

rct@gherkin.frus.com (Bob_Tracy) reported this for 2.5.38.  He was 
requested to try the next version to see if the problem still exists.  I 
have not seen a followup.  Does the problem still exist?
-------------------------------------------------------------------------
   open                   27 Sep 2002 oops on modprobe sg
  18. http://marc.theaimsgroup.com/?l=linux-kernel&m=103313163215676&w=2

This problem appears related to the other ide-scsi problem reported above.  
Should there be a single item tracking problems with inserting and 
removing ide-scsi related modules?
-------------------------------------------------------------------------
   open                   29 Sep 2002 oops on boot in 2.5.39
  19. http://marc.theaimsgroup.com/?l=linux-kernel&m=103334726918669&w=2

   additional report      01 Oct 2002 also in 2.5.40
  20. http://marc.theaimsgroup.com/?l=linux-kernel&m=103343520729702&w=2

Several people have reported oops on boot in device_attach.  It may be 
related to isapnp, but that is not confirmed.
-------------------------------------------------------------------------
   open                   30 Sep 2002 P4 clock modulation crash
  21. http://marc.theaimsgroup.com/?l=linux-kernel&m=103341311908313&w=2

   possible fix available 01 Oct 2002
  22. http://marc.theaimsgroup.com/?l=linux-kernel&m=103341862014756&w=2

This was reported for 2.5.39.  Dominik Brodowski <linux@brodo.de> reported 
a probable fix and sent it to Linus.  I will delete this item when Linus 
issues 2.5.41 unless someone objects.
-------------------------------------------------------------------------
   possible fix available 03 Oct 2002 Menuconfig is broken
  23. http://marc.theaimsgroup.com/?l=linux-kernel&m=103356058613554&w=2

Numerous people reported this problem, and a fix was discussed.  I will 
await results from 2.5.41 testing to decide whether to delete this item or 
not.
-------------------------------------------------------------------------
   open                   2.5.40      init_irq() function doing unsafe 
                                      things inside ide_lock
  24. http://marc.theaimsgroup.com/?l=linux-kernel&m=103316967724891&w=2

Might sleep while holding a lock.
-------------------------------------------------------------------------
   open                   2.5.40      usb_hub_events() does down() in 
                                      hub_event_lock
  25. http://marc.theaimsgroup.com/?l=linux-kernel&m=103317380027379&w=2

Might sleep while holding a lock.
-------------------------------------------------------------------------
   open                   2.5.40      pci_pool_create() calling 
                                      device_create_file() under 
                                      pools_lock
  26. http://marc.theaimsgroup.com/?l=linux-kernel&m=103317380227383&w=2

Might sleep while holding a lock.
-------------------------------------------------------------------------
   open                   2.5.40      register_console() called in illegal 
                                      context
  27. http://marc.theaimsgroup.com/?l=linux-kernel&m=103282695403237&w=2

Might sleep while holding a lock.
-------------------------------------------------------------------------
   open                   2.5.40      eata2x_detect() calls port_detect() 
                                      under driver_lock
  28. http://marc.theaimsgroup.com/?l=linux-kernel&m=103281310122580&w=2

Might sleep while holding a lock.
-------------------------------------------------------------------------
   fix in bk              2.5.40      sys_ioperm() is calling 
                                      kmalloc(GFP_KERNEL) in 
                                      preempt_disable()
  29. http://marc.theaimsgroup.com/?l=linux-kernel&m=103281732827302&w=2

Might sleep while holding a lock.
-------------------------------------------------------------------------
   fix in bk              2.5.40      snd_pcm_oss_poll() calls poll_wait() 
                                      in runtime->lock
  30. http://marc.theaimsgroup.com/?l=linux-kernel&m=103281732827302&w=2

   possible fix available 04 Oct 2002 sg_init() vmalloc() in 
                                      write_lock_irqsave
  31. http://marc.theaimsgroup.com/?l=linux-kernel&m=103327490712028&w=2

Might sleep while holding a lock.
-------------------------------------------------------------------------
   open                   2.5.40      snd_ctl_elem_write() calls 
                                      snd_ctl_notify() under read_lock
  32. http://marc.theaimsgroup.com/?l=linux-kernel&m=103327490412023&w=2

Might sleep while holding a lock.
-------------------------------------------------------------------------
   open                   2.5.40      sym_eh_handler does down(&ep->sem) 
                                      and might sleep
  33. http://marc.theaimsgroup.com/?l=linux-kernel&m=103372067026942&w=2

Might sleep while holding a lock.
-------------------------------------------------------------------------
   open                   03 Oct 2002 module loading problem
  34. http://marc.theaimsgroup.com/?l=linux-kernel&m=103351991417181&w=2

-------------------------------------------------------------------------
   open                   02 Oct 2002 raid0_make_request bug
  35. http://marc.theaimsgroup.com/?l=linux-kernel&m=103357721401461&w=2

-------------------------------------------------------------------------
   open                   02 Oct 2002 Keyboard problems
  36. http://marc.theaimsgroup.com/?l=linux-kernel&m=103352741722028&w=2

-------------------------------------------------------------------------
   open                   03 Oct 2002 ACPI Mutex failure
  37. http://marc.theaimsgroup.com/?l=linux-kernel&m=103369523011536&w=2

-------------------------------------------------------------------------
   open                   02 Oct 2002 DAC960 broken
  38. http://marc.theaimsgroup.com/?l=linux-kernel&m=103351317411581&w=2

-------------------------------------------------------------------------
   open                   02 Oct 2002 oops when rebooting 2.5.40 in 
                                      driverfs_remove_file
  39. http://marc.theaimsgroup.com/?l=linux-kernel&m=103382033404384&w=2

-------------------------------------------------------------------------
   open                   04 Oct 2002 SCSI st tape wrong minor
  40. http://marc.theaimsgroup.com/?l=linux-kernel&m=103382033204377&w=2

-------------------------------------------------------------------------
   open                   04 Oct 2002 serial cons prob on reboot in 2.5
  41. http://marc.theaimsgroup.com/?l=linux-kernel&m=103382033004372&w=2

-------------------------------------------------------------------------


