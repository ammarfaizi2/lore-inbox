Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264665AbTAEMOi>; Sun, 5 Jan 2003 07:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264672AbTAEMOi>; Sun, 5 Jan 2003 07:14:38 -0500
Received: from tomts15.bellnexxia.net ([209.226.175.3]:54243 "EHLO
	tomts15-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S264665AbTAEMOh>; Sun, 5 Jan 2003 07:14:37 -0500
Date: Sun, 5 Jan 2003 07:23:51 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: my take on the 2.5 xconfig screen -- for what it's worth
Message-ID: <Pine.LNX.4.44.0301050702300.18401-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  ... from someone who is still wet behind the ears when it comes to
digging into the kernel ... so be gentle :-)

  there's one issue with the new graphical "xconfig" screen in 2.5
that's been nagging quietly at me since i saw it for the first time,
so i thought i'd just mention it.  it's *incredibly* picky, but
what the heck.

  i find the *structure* (not the content, mind you) a little awkward
in terms of the way hierarchical choices are represented.  here's what
i mean.

  when you run "make xconfig" and if you collapse all of the "-" menu
chocies, even the entries with no "+" expansion boxes *still* represent
a master choice for sub menu options.  as one example, "Processor type
and features".  in the main list, there's no indication that this 
represents a truckload of subchoices which will show up in the right
nand window when you click on it.  this can be said of many of those
menus, obviously.  

  this (admittedly slightly) non-intuitive behavior becomes more
confusing, however, when you have main menu entries like "Power
management options" or "Networking options".  both of these choices
have a "+" (expandable) icon, but that's *in addition* to just
clicking on the menu entry itself, which apparently shows you 
what i presume are basic networking options -- expanding on that
entry then shows advanced networking settings.  (Power management
options is a good example of what i consider to be a confusing
structure: while the entry is labelled with "(ACPI, APM)", the
APM is under the main entry, while ACPI is available only after
you expand the entry.  confusing.)

  this way of representing hierarchical submenus flies in the face
of what most people will be used to.  as a long-standing practice,
consider the way netscape/mozilla bookmarks are set up, or the older
tcl/tk(?) xconfig screen from the 2.4 kernel.  these were more
intuitive -- *everything* at the top level was an expandable menu
choice.  i realize that the way this is set up is for faster access,
but it just feels awkward.  (in the case of bookmarks, everything
in a bookmark list is clearly a direct bookmark, or a folder for
more bookmarks -- what i consider a clear, intuitive design).

  more than anything, it reminds me of what you *can't* do with
pine mail folders.  in pine, while you can set up hierarchical
folders, you *can't* use the same folder both for storage and for
a parent folder of subfolders.  in other words, i'm not allowed
to store mail in both the folder "kernel", and in "kernel/2.4",
"kernel/2.5" and so on.  and this is exactly what this hierarchy
is trying to do.

  anyway, like i said, this is almost pathologically picky, but
it's what i do best. :-)

rday

