Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265400AbTABCny>; Wed, 1 Jan 2003 21:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbTABCny>; Wed, 1 Jan 2003 21:43:54 -0500
Received: from tomts26-srv.bellnexxia.net ([209.226.175.189]:6854 "EHLO
	tomts26-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S265400AbTABCnx>; Wed, 1 Jan 2003 21:43:53 -0500
Date: Wed, 1 Jan 2003 21:51:23 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: more observations on 2.5 config menus
Message-ID: <Pine.LNX.4.44.0301012136410.4436-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  based on 2.5.53 with the absolute latest tagged-to-head.v2.5
stuff:

Fusion MPT device support
 
    and ... where's the contents of that menu entry?

Character devices -> Serial drivers

    Entry "Non-8250 serial port support" -- what is that entry
  doing there?  it has no submenu and is not selectable.  I've
  noticed entries like this being used as comments in the
  *middle* of menu lists, but this doesn't appear to have
  any value here.  I recall at least one other example like
  that somewhere.

Loadable module support

    Still curious about whether it makes sense to deselect
  "Module unloading" while being able to select "Forced module
  unloading"

Power management options (ACPI, APM)

    Based on that menu label, which suggests that ACPI and
  APM are equally viable options to select for power
  management, it's confusing that you can deselect 
  "Power management support", and yet *still* have to 
  explicitly deselect ACPI support beyond that.

USB support -> USB Mass Storage support

    It might be helpful for the help screen for that entry
  to explicitly list USB zip drives, just in case anyone
  wasn't sure.  Picky, yes.

Plug and play support

    The help screen is ambiguous when it states, toward the
  bottom, "Alternatively, you can say N here ..."  "N" to which
  of the above?  The entire option?  Or each of the suboptions?
  That can be read either way.


rday

