Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbTABC4J>; Wed, 1 Jan 2003 21:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265475AbTABC4J>; Wed, 1 Jan 2003 21:56:09 -0500
Received: from tomts11.bellnexxia.net ([209.226.175.55]:11438 "EHLO
	tomts11-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S265457AbTABC4I>; Wed, 1 Jan 2003 21:56:08 -0500
Date: Wed, 1 Jan 2003 22:03:36 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: inconsistent design of menus and submenus in 2.5.53
Message-ID: <Pine.LNX.4.44.0301012153530.4495-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  once again, using 2.5.53 with the latest tagged-to-head.v2.5,
there is a noticeable inconsistency in the display of menus and
their submenus.

  consider Plug and Play support -- this, IMHO, is correctly
done, with all possible sub-options *once you select the main
feature*, all indented one level below the controlling top-level
selection.

  another example of this (good) design is the recent addition
of the 10/100 Mbit and 1000 Mbit options under Network device
support, once again showing clearly the child option structure.

  contrast that with Parallel port support, where lower options
in the list that *appear* to be sibling choices to Parallel
port support are actually child options that vanish when you
deselect Parallel port support.  very confusing.

  and under Bus options (...), note the *very* weird structure
where PCI access mode is, confusingly, a child option of the
top-level PCI support selection, even though the same-level
"Support for hot-pluggable devices" further down is *not*
a child of PCI support.

  is this making any sense?

rday

