Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbSJLQl7>; Sat, 12 Oct 2002 12:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbSJLQl7>; Sat, 12 Oct 2002 12:41:59 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:56966 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S261289AbSJLQlu>;
	Sat, 12 Oct 2002 12:41:50 -0400
Date: Sat, 12 Oct 2002 11:47:35 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
Subject: 2.5 Problem Report Status (fwd)
Message-ID: <Pine.LNX.4.44.0210121146370.4532-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resend; I apologize if this is received twice.  A later post appeared in 
the mailing list but this one didn't.

---------- Forwarded message ----------
Date: Sat, 12 Oct 2002 10:38:21 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
To: linux-kernel@vger.kernel.org
Cc: Eriksson Stig <stig.eriksson@sweco.se>, Burton Windle <bwindle@fint.org>,
     Murray J. Root <murrayr@brain.org>, Adam J. Richter <adam@yggdrasil.com>,
     Mikael Pettersson <mikpe@csd.uu.se>, Bob_Tracy <rct@gherkin.frus.com>,
     Luc Van Oostenryck <luc.vanoostenryck@easynet.be>,
     Greg KH <greg@kroah.com>, William Lee Irwin III <wli@holomorphy.com>,
     Andrew Morton <akpm@digeo.com>, Anton Blanchard <anton@samba.org>,
     Martin Dahl <dahlm@izno.net>, Jurriaan <thunder7@xs4all.nl>,
     David Ashley <dash@xdr.com>, Sylvain Pasche <sylvain_pasche@yahoo.fr>,
     Eric Altendorf <EricAltendorf@orst.edu>,
     Bjoern A. Zeeb <bzeeb-lists@lists.zabbadoz.net>, jbradford@dial.pipex.com,
     David Ashley <dash@xdr.com>, Arador <diegocg@teleline.es>,
     Jonathan Hudson <jonathan@daria.co.uk>,
     Morten Helgesen <morten.helgesen@nextframe.net>,
     Dave Hansen <haveblue@us.ibm.com>, Steven King <sxking@qwest.net>,
     Barry K. Nathan <barryn@pobox.com>, Helge Hafting <helgehaf@aitel.hist.no>,
     Banai Zoltan <bazooka@vekoll.vein.hu>, Alan Willis <alan@cotse.net>,
     Vojtech Pavlik <vojtech@suse.cz>,
     Arnaud Gomes-do-Vale <arnaud@carrosse.frmug.org>,
     Maciej Babinski <maciej@imsa.edu>, Stig Brautaset <stig@brautaset.org>,
     Andries.Brouwer@cwi.nl
Subject: 2.5 Problem Report Status

This status report can be access at:

http://members.cox.net/tmolina/kernprobs/021012-status.html

The latest report can always be accessed at:

http://members.cox.net/tmolina/status.html


                               2.5 Kernel Problem Reports as of 12 Oct

   Status                 Discussion  Problem Title

   open                   04 Oct 2002 AIC7XXX boot failure

   1. http://marc.theaimsgroup.com/?l=linux-kernel&m=103356254615324&w=2

A number of changes went in 2.5.42 which seem to affect this subsystem.  I 
can't tell if any of them fix the reported problem.  Can I have an update 
here?
--------------------------------------------------------------------------
   open                   05 Oct 2002 oops in lock_get_status

   2. http://marc.theaimsgroup.com/?l=linux-kernel&m=103244657605155&w=2

This was originally reported as "oops when reading /proc/locks".  I 
understand the developer was still working on it.  I've seen no further 
discussion.
--------------------------------------------------------------------------
   open                   30 Sep 2002 ide-scsi hangs on boot

   3. http://marc.theaimsgroup.com/?l=linux-kernel&m=103336376827272&w=2

I've seen no specific followup on the original report.  This problem 
report will be folded into the generic problems loading/unloading ide-scsi 
modules unless some objection is received.
--------------------------------------------------------------------------
   open                   11 Oct 2002 problems loading ide-scsi modules

   4. http://marc.theaimsgroup.com/?l=linux-kernel&m=103388771007676&w=2

Several people have reported oops/hangs when inserting and/or removing 
ide-scsi modules.  
--------------------------------------------------------------------------
   open                   08 Oct 2002 IDE problems on prePCI

   5. http://marc.theaimsgroup.com/?l=linux-kernel&m=103277899317468&w=2

No specific followups have been posted to lkml to my knowledge.  I have 
been told this problem is being worked.  Are there any updates, or is this 
problem fixed?
--------------------------------------------------------------------------
   possible fix available 10 Oct 2002 modular IDE broken

   6. http://marc.theaimsgroup.com/?l=linux-kernel&m=103281667726673&w=2

"Adam J. Richter" <adam@yggdrasil.com> posted a patch which purports to 
fix this problem.  Can this be confirmed, and will it be integrated?
--------------------------------------------------------------------------
   open                   09 Oct 2002 USB Mass Storage problems

   7. http://marc.theaimsgroup.com/?l=linux-kernel&m=103404393623200&w=2

--------------------------------------------------------------------------
   open                   09 Oct 2002 init_irq() function doing unsafe 
                                      things inside ide_lock

   8. http://marc.theaimsgroup.com/?l=linux-kernel&m=103316967724891&w=2

--------------------------------------------------------------------------
   open                   06 Oct 2002 usb_hub_events() does down() in 
                                      hub_event_lock

   9. http://marc.theaimsgroup.com/?l=linux-kernel&m=103317380027379&w=2

--------------------------------------------------------------------------
   open                   04 Oct 2002 register_console() called in illegal 
                                      context

  10. http://marc.theaimsgroup.com/?l=linux-kernel&m=103282695403237&w=2

--------------------------------------------------------------------------
   open                   09 Oct 2002 eata2x_detect() calls port_detect() 
                                      under driver_lock

  11. http://marc.theaimsgroup.com/?l=linux-kernel&m=103281310122580&w=2

--------------------------------------------------------------------------
   open                   04 Oct 2002 sym_eh_handler does down(&ep->sem) 
                                      and might sleep

  12. http://marc.theaimsgroup.com/?l=linux-kernel&m=103372067026942&w=2

--------------------------------------------------------------------------
   open                   08 Oct 2002 mremap() pte allocation atomicity 
                                      error

  13. http://marc.theaimsgroup.com/?l=linux-kernel&m=103319113503055&w=2

--------------------------------------------------------------------------
   open                   07 Oct 2002 illegal sleeping function called 
                                      from acpi_os_wait_semaphore()

  14. http://marc.theaimsgroup.com/?l=linux-kernel&m=103404677824885&w=2

--------------------------------------------------------------------------
   open                   09 Oct 2002 migration_thread atomicity error

  15. http://marc.theaimsgroup.com/?l=linux-kernel&m=103408159014496&w=2

--------------------------------------------------------------------------
   open                   08 Oct 2002 snd_via8233 atomicity error

  16. http://marc.theaimsgroup.com/?l=linux-kernel&m=103410375210315&w=2

--------------------------------------------------------------------------
   open                   11 Oct 2002 scheduling while atomic in 
                                      autofs4_root_lookup

  17. http://marc.theaimsgroup.com/?l=linux-kernel&m=103426998326969&w=2

--------------------------------------------------------------------------
   open                   02 Oct 2002 module loading problem

  18. http://marc.theaimsgroup.com/?l=linux-kernel&m=103351991417181&w=2

This was my initial report on problems loading/unloading ide-scsi modules.  
The problem continues through 2.5.41.  I will fold this into a single 
report covering problems loading/unloading ide-scsi modules.
--------------------------------------------------------------------------
   open                   03 Oct 2002 ACPI Mutex failure

  19. http://marc.theaimsgroup.com/?l=linux-kernel&m=103369523011536&w=2

--------------------------------------------------------------------------
   open                   04 Oct 2002 serial cons prob on reboot in 2.5

  20. http://marc.theaimsgroup.com/?l=linux-kernel&m=103382033004372&w=2

--------------------------------------------------------------------------
   open                   06 Oct 2002 initrd breakage

  21. http://marc.theaimsgroup.com/?l=linux-kernel&m=103364305822611&w=2

--------------------------------------------------------------------------
   open                   05 Oct 2002 2.5.x and 8250 UART problems

  22. http://marc.theaimsgroup.com/?l=linux-kernel&m=103383019409525&w=2

--------------------------------------------------------------------------
   open                   07 Oct 2002 mouse/keyboard freeze in X

  23. http://marc.theaimsgroup.com/?l=linux-kernel&m=103388829207870&w=2

This was broke, then fixed, now is apparently broke again.
--------------------------------------------------------------------------
   open                   06 Oct 2002 kernel BUG at slab.c:1477

  24. http://marc.theaimsgroup.com/?l=linux-kernel&m=103388771007676&w=2

This is yet another report of problems loading/unlaoding ide-scsi modules.  
It will be folded into a single report covering problems loading/unloading 
ide-scsi modules.
--------------------------------------------------------------------------
   open                   07 Oct 2002 bug related to virtual consoles

  25. http://marc.theaimsgroup.com/?l=linux-kernel&m=103403138113853&w=2

--------------------------------------------------------------------------
   open                   07 Oct 2002 oops in kmem_cache_create

  26. http://marc.theaimsgroup.com/?l=linux-kernel&m=103403423716317&w=2

--------------------------------------------------------------------------
   open                   07 Oct 2002 USB Hub failure

  27. http://marc.theaimsgroup.com/?l=linux-kernel&m=103402696809279&w=2

--------------------------------------------------------------------------
   open                   08 Oct 2002 oops in move_page_tables

  28. http://marc.theaimsgroup.com/?l=linux-kernel&m=103411727925975&w=2

--------------------------------------------------------------------------
   open                   08 Oct 2002 boot problem on 440GX

  29. http://marc.theaimsgroup.com/?l=linux-kernel&m=103399796506960&w=2

--------------------------------------------------------------------------
   open                   08 Oct 2002 oops in run_timer_tasklet

  30. http://marc.theaimsgroup.com/?l=linux-kernel&m=103393743102152&w=2

--------------------------------------------------------------------------
   open                   08 Oct 2002 oops while running kjournald

  31. http://marc.theaimsgroup.com/?l=linux-kernel&m=103408191314814&w=2

--------------------------------------------------------------------------
   open                   09 Oct 2002 64GB highmem BUG()

  32. http://marc.theaimsgroup.com/?l=linux-kernel&m=103399745406334&w=2

--------------------------------------------------------------------------
   open                   10 Oct 2002 pl2303 oops

  33. http://marc.theaimsgroup.com/?l=linux-kernel&m=103420708602707&w=2

--------------------------------------------------------------------------
   open                   09 Oct 2002 Attempt to release TCP socket errors

  34. http://marc.theaimsgroup.com/?l=linux-kernel&m=103409524231641&w=2

--------------------------------------------------------------------------
   open                   09 Oct 2002 raid problems in 2.5

  35. http://marc.theaimsgroup.com/?l=linux-kernel&m=103414903003887&w=2

--------------------------------------------------------------------------
   open                   06 Oct 2002 analog joystick oops

  36. http://marc.theaimsgroup.com/?l=linux-kernel&m=103393598801189&w=2

--------------------------------------------------------------------------
   open                   07 Oct 2002 DRI not working

  37. http://marc.theaimsgroup.com/?l=linux-kernel&m=103403348315804&w=2

--------------------------------------------------------------------------
   open                   10 Oct 2002 keyboard generates bogus key results

  38. http://marc.theaimsgroup.com/?l=linux-kernel&m=103423327423623&w=2

--------------------------------------------------------------------------
   open                   10 Oct 2002 no mouse wheel

  39. http://marc.theaimsgroup.com/?l=linux-kernel&m=103351918416613&w=2

--------------------------------------------------------------------------
   open                   10 Oct 2002 PCMCiA trouble

  40. http://marc.theaimsgroup.com/?l=linux-kernel&m=103420230730597&w=2

--------------------------------------------------------------------------
   open                   11 Oct 2002 apm hangs instead of suspending

  41. http://marc.theaimsgroup.com/?l=linux-kernel&m=103432997711883&w=2

--------------------------------------------------------------------------
   open                   11 Oct 2002 tcp urgent data broken

  42. http://marc.theaimsgroup.com/?l=linux-kernel&m=103429736523667&w=2

--------------------------------------------------------------------------




