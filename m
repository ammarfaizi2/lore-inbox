Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265421AbRFVOBB>; Fri, 22 Jun 2001 10:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265417AbRFVOAv>; Fri, 22 Jun 2001 10:00:51 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:46866 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S265419AbRFVOAt>; Fri, 22 Jun 2001 10:00:49 -0400
From: Nikita Danilov <NikitaDanilov@Yahoo.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15155.20320.401924.865523@beta.namesys.com>
Date: Fri, 22 Jun 2001 18:00:00 +0400
To: Vasil Kolev <lnxkrnl@mail.ludost.net>
Cc: <reiserfs-list@namesys.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-list] Incompatibility between the reisrefs patches
 for 2.2.x and 2.4.x
In-Reply-To: <Pine.LNX.4.33.0106221622060.24629-100000@doom.bastun.net>
In-Reply-To: <15155.17923.423044.21965@beta.namesys.com>
	<Pine.LNX.4.33.0106221622060.24629-100000@doom.bastun.net>
X-Mailer: VM 6.89 under 21.1 (patch 8) "Bryce Canyon" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vasil Kolev writes:
 > Can I use the new format with 2.2? I don't have enough space to do that...
 > I would live with the limitations ... I just want it to work :)

I am afraid you cannot. Not now at least. Sorry.

 > 
 > On Fri, 22 Jun 2001, Nikita Danilov wrote:
 > 
 > > Vasil Kolev writes:
 > >  > Maybe this is a know issue, but nonetheless.....
 > >  > I have dual coppermine/930 machine with 1.2G ram, kernel 2.4.5. I used
 > >  > reiserfs for my  /home and /var partitions. When tried downgrading to
 > >  > 2.2.19, I got errors  in syslog like 'can't find superblock' ... ( I don't
 > >  > have them, /var wasn't mounted, and i had to return the machine in
 > >  > production state... ). Does someone has any idea about this, how could I
 > >  > downgrade to 2.2.19 ?
 > >
 > > 2.4 kernels can work with both 3.5 reiserfs disk format (old) and 3.6
 > > (new). 2.2 kernels---only with 3.5. Probably, you have created your
 > > file-systems in the new format.
 > >
 > > You can boot 2.4 kernel, create new file-system large enough with
 > > /sbin/mkreiserfs -v1 (old format), copy existing files there by tar or
 > > cpio and then update /etc/fstab to mount file-system just created. Now,
 > > you can work both with 2.2 and 2.4 kernels.
 > >
 > > Keep in mind, that 3.5 format has some limitations concerning file size
 > > etc. Check faq at namesys.com for details. On the other hand, 3.5 often
 > > considered more stable.
 > >

Nikita.

 > >
