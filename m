Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUHHTMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUHHTMA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 15:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUHHTMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 15:12:00 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:64751 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262380AbUHHTL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 15:11:58 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: skraw@ithnet.com, vojtech@suse.cz, hpa@zytor.com
Content-Type: text/plain
Organization: 
Message-Id: <1091983220.5759.159.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 08 Aug 2004 12:40:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski writes:

> Maybe you should not overestimate cdrecord as a tool
> (like its author obviously does sometimes). At least
> for DVD there are well-working alternatives.

Unfortunately there is quite a bit of knowledge embedded
in cdrecord. There are _lots_ of weird formats and burners
to take care of. Testing costs real money. Mistakes will
cost real money for many other people.

Sorry. **ahem** This would be an easy project...

> If Joerg feels a better home on Solaris, so be it. 
> It's his right to decide for solaris, just as it is
> a users' right to decide against cdrecord.

True.

Oddly, he did admit that Solaris will support direct usage
of the device names. Here's his list of good systems:

Linux
AIX
BSD-OS (eh, meaning BSDI maybe?)
OpenBSD 
HP-UX   
SGI IRIX
Solaris

Here are the bad systems:

obsolete releases of Linux and Solaris
dead OSes like DOS, DomainOS, AmigaOS, BeOS, NeXT, SunOS 4
nearly dead: VMS, OS/2, Tru64 
SCO crap: OpenServer, UnixWare
Windows
MacOS X
QNX
FreeBSD (Maybe it's dying? It's a BSD.)

If support for the bad systems were discontinued, FreeBSD and
MacOS X would most likely be fixed up soon. Maybe QNX too.
The others can sink. Supporting SCO is just plain wrong.

So you certainly could fork this, drop the silly naming, and
still support the OSes worth caring about.


