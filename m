Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130586AbRCEBts>; Sun, 4 Mar 2001 20:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130585AbRCEBtj>; Sun, 4 Mar 2001 20:49:39 -0500
Received: from web11801.mail.yahoo.com ([216.136.172.155]:23054 "HELO
	web11801.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130593AbRCEBta>; Sun, 4 Mar 2001 20:49:30 -0500
Message-ID: <20010305014929.69993.qmail@web11801.mail.yahoo.com>
Date: Sun, 4 Mar 2001 17:49:29 -0800 (PST)
From: "Frédéric L. W. Meunier" <fredlwm1@yahoo.com>
Subject: Re: 2.4.2: What happened ? (No such file or directory)
To: Jeremy Jackson <jerj@coplanar.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AA26659.89222B2B@coplanar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jeremy Jackson <jerj@coplanar.net> wrote:
> " Frédéric L. W. Meunier" wrote:
> 
> > Correction. I can umount the partitions, but I get
> the
> > following message:
> >
> > "can't link lock file /etc/mtab~: No such file or
> > directory (use -n flag to override)"
> >
> > And /etc/mtab isn't updated.
> 
> Is your root filesystem mounted read-only at any
> point?
> (check with 'mount' look for ro in line for /
> filesystem)
> Check permissions on /etc, /etc/mtab, /etc/mtab~

/dev/ide/host0/bus0/target0/lun0/part1 on / type ext2
(rw)
/dev/ide/host0/bus0/target0/lun0/part3 on
/usr/local/src type ext2 (rw)
proc on /proc type proc (rw)

But it's not only umount. Most applications can't find
files, I can't move directories with mc (but mv(1)
works), all symlinks I create point to the symlink,
not the existing file or directory...

__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/
