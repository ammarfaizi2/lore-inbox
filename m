Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268754AbTBZONo>; Wed, 26 Feb 2003 09:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268755AbTBZONo>; Wed, 26 Feb 2003 09:13:44 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:12188 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S268754AbTBZONn> convert rfc822-to-8bit; Wed, 26 Feb 2003 09:13:43 -0500
Cc: linux-kernel@vger.kernel.org
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk>
	<b3i4nv$sud$1@news.cistron.nl> <87u1er71d0.fsf@goat.bogus.local>
	<yw1xwujn2t0v.fsf@manganonaujakasit.e.kth.se>
	<87el5v6xvj.fsf@goat.bogus.local>
	<yw1xn0kjdxv4.fsf@manganonaujakasit.e.kth.se>
	<8765r76u0c.fsf@goat.bogus.local>
	<yw1xlm03uoz4.fsf@manganonaujakasit.e.kth.se>
From: Olaf Dietsche <olaf.dietsche@t-online.de>
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: About /etc/mtab and /proc/mounts
Date: Wed, 26 Feb 2003 15:23:33 +0100
In-Reply-To: <yw1xlm03uoz4.fsf@manganonaujakasit.e.kth.se> (mru@users.sourceforge.net's
 message of "26 Feb 2003 14:54:23 +0100")
Message-ID: <87znoj5dei.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Military
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@users.sourceforge.net (Måns Rullgård) writes:

> What does your /proc/mounts look like when the cdrom is mounted?  Are

$ grep cdrom /proc/mounts
/dev/hdb/0 /cdrom iso9660 ro,nosuid,nodev,noexec 0 0

> you using a standard mount, or something hacked up by RH or others?

Debian unstable, but I didn't upgrade mount for quite some time.

$ dpkg -l mount
ii  mount            2.11n-4          Tools for mounting and manipulating filesystems.

Regards, Olaf.
