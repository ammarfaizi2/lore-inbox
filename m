Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265179AbUEZFJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265179AbUEZFJo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 01:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUEZFJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 01:09:44 -0400
Received: from gizmo04bw.bigpond.com ([144.140.70.14]:36252 "HELO
	gizmo04bw.bigpond.com") by vger.kernel.org with SMTP
	id S265179AbUEZFJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 01:09:42 -0400
Subject: [Fwd: Re: drivers DB and id/ info registration]
From: Zenaan Harkness <zen@freedbms.net>
To: linux-kernel@vger.kernel.org
Cc: "debian-devel@lists.debian.org" <debian-devel@lists.debian.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1085548092.2909.60.camel@zen8100a.freedbms.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 26 May 2004 15:08:13 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think we need to somehow make it easy for manufacturers to submit
information about their hardware - something centralized, kernel- and
distro- neutral, that can be widely advertised to manufacturers.

Here is what I've found so far for id DBs, and it seems a bit all over
the place:

PCI
==============================
http://pciids.sourceforge.net/

Which has a submit new entry form, which asks for ID, Name, Comment and
Email only, here:
http://pciids.sourceforge.net/iii/?sub=1

Printers
==============================
http://www.linuxprinting.org/kpfeifle/LinuxKongress2002/Tutorial/VIII.Foomatic-Contribution/VIII.tutorial-handout-foomatic-contribution.html
Which has a forum for submission, and a list of information to
describe the printer, seems aimed at users:
      * Manufacturer's name
      * Model name
      * Mechanism type (as laser, inkjet, dot matrix, ...)
      * Color or black-and-white?
      * Maximum resolution claimed by the manufacturer and obtained by
        you with free software
      * Connection types (Parallel, USB, Ethernet, ...)
      * Maximum paper size
      * Special functionality (multi-function device, finishers, ...)
      * Type of consumables/refills (as "one black and one color
        cartridge", "toner/drum unit", ... not only "cartridge(s)")
      * How did you get it to work? Which driver(s) did you use and with
        which option settings? Which driver do you recommend? Did you
        apply special tricks (as hacking the driver's code, using an
        additional filter, ...) to get the printer to work?
      * Also reporting that a printer does not work at all is important
        for us, users should be warned before they buy a "Paperweight".
      * What is your impression of the results? Categorize your printer
        in one of the levels described on the database introduction page
        (http://www.linuxprinting.org/database.html).
Also has suggestions to manufacturers further below.

USB
==============================
http://www.linux-usb.org/usb.ids
http://www.linux-usb.org/
Various links, mailing lists, a working devices list, etc.
Also a link to Linux USB Guide:
http://www.linux-usb.org/USB-guide/book1.html
No clear submission for manufacturers.

Firewire
==============================
Can't readily find anything with google.

=========
So, does it make sense to create a centralized repository, and/ or an
FAQ for manufacturers.

I really think it needs to be easy for manufacturers to supply
information. I have no doubt that there must be a standardized process
at MS whereby manufacturers can submit device, id, name and other driver
information directly to microsoft and have it included in the next
service pack. I'm guessing here though, but it does seem like we in the
free software community are playing catch up, and that that is in some
way simply an organizational problem.

All thoughts, suggestions, further links to add to the above list, etc,
very much appreciated.
