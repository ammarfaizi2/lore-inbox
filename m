Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268727AbTBZMGG>; Wed, 26 Feb 2003 07:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268728AbTBZMGG>; Wed, 26 Feb 2003 07:06:06 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:54933 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S268727AbTBZMGE> convert rfc822-to-8bit; Wed, 26 Feb 2003 07:06:04 -0500
Cc: miquels@cistron-office.nl (Miquel van Smoorenburg),
       linux-kernel@vger.kernel.org
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk>
	<b3i4nv$sud$1@news.cistron.nl> <87u1er71d0.fsf@goat.bogus.local>
	<yw1xwujn2t0v.fsf@manganonaujakasit.e.kth.se>
From: Olaf Dietsche <olaf.dietsche@t-online.de>
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: About /etc/mtab and /proc/mounts
Date: Wed, 26 Feb 2003 13:16:00 +0100
In-Reply-To: <yw1xwujn2t0v.fsf@manganonaujakasit.e.kth.se> (mru@users.sourceforge.net's
 message of "26 Feb 2003 12:14:24 +0100")
Message-ID: <87el5v6xvj.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Military
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@users.sourceforge.net (Måns Rullgård) writes:

> Olaf Dietsche <olaf.dietsche@t-online.de> writes:
>
>> I thought, this is what /var is for. So, /var/run, /var/lib/misc or
>> /var/etc might be more appropriate?
>
> What if /var is mounted separately?

I didn't think of this, even though I have it separately on my
machine.

>> OTOH, "ln -s /proc/mounts /etc/mtab" works just fine here.
>
> The only problem I have with that is that option 'user' is lost.  This
> means that any user can mount /cdrom, but only root can unmount it.

The 'user' option is in /etc/fstab, so this is not a problem. I can
mount _and_ umount /cdrom as a simple user.

Regards, Olaf.
