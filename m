Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269372AbTCDLGm>; Tue, 4 Mar 2003 06:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269379AbTCDLFe>; Tue, 4 Mar 2003 06:05:34 -0500
Received: from [66.70.28.20] ([66.70.28.20]:26892 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S269378AbTCDLFa>; Tue, 4 Mar 2003 06:05:30 -0500
Date: Tue, 4 Mar 2003 12:02:13 +0100
From: DervishD <raul@pleyades.net>
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: Miles Bader <miles@gnu.org>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
Message-ID: <20030304110213.GA42@DervishD>
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk> <buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp> <20030302125315.GH45@DervishD> <3E620E71.B74C2191@daimi.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E620E71.B74C2191@daimi.au.dk>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Kasper :)

 Kasper Dupont dixit:
> >  Miles Bader dixit:
> > > /var is clearly the right place for this; if /var isn't mounted
> > > initially, I'd suggest that mount should simply not update any file
> > > at that point, and the init-script that mounts /var can be
> > > responsible from propagating information from /proc/mounts to
> > > /var/whatever.
> >     In an embedded system I built a time ago, /etc/mtab was first a
> > symlink to /proc/mounts, but after a while I made it a symlink to
> > /var/run/mtab. It worked OK, AFAIK.
> Did mount actually update the mtab file? The version of mount on
> my system would not.

    Of course not, it is just a symlink to a proc file ;))) I must
say that it worked OK but really only ext2 filesystems and a CDROM
were mounted, with default options. Don't know if the symlink would
have been worked if special options were used. Now that I remember,
we only use 'special' options for the CDROM (to allow mounting by
normal users) and the devpts (the permissions).

    Raúl
