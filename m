Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293352AbSCKJU1>; Mon, 11 Mar 2002 04:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293366AbSCKJUR>; Mon, 11 Mar 2002 04:20:17 -0500
Received: from andromeda.regiocom.net ([62.144.72.200]:1540 "EHLO
	andromeda.regiocom.net") by vger.kernel.org with ESMTP
	id <S293352AbSCKJUJ>; Mon, 11 Mar 2002 04:20:09 -0500
From: Erik Meusel <meusel@codixx.de>
Reply-To: meusel@codixx.de
Organization: CODIXX AG
To: linux-kernel@vger.kernel.org
Subject: Re: Ext2/3 uid/gid support
Date: Mon, 11 Mar 2002 10:22:33 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
In-Reply-To: <E16j1Z6-0002xf-00@the-village.bc.nu> <02031109444400.00601@huschki> <20020311084741.GC311@matchmail.com>
In-Reply-To: <20020311084741.GC311@matchmail.com>
MIME-Version: 1.0
Message-Id: <02031110223301.00601@huschki>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 11. März 2002 09:47 schrieb Mike Fedyk:
> On Mon, Mar 11, 2002 at 09:44:44AM +0100, Erik Meusel wrote:
> > Hi.
> >
> > Just one little question:
> >
> > Why do ext2 and ext3 not support mount options uid and gid as all the
> > other  filesystems do?
>
> because they have uid and gid within the filesystem itself for directories,
> files, pipes, etc stored in the inodes of the fs.  Same with any other
> posix filesystem (which vfat, iso9660(not counting rockridge), hfs, etc are
> *not*).
Sure.
The reason why I ask is, I have two linux stations and I want to use ext2
for the floppy disks to save space for fat vfat and so on. Now it would
be nice to automatically mount my floppies with group "floppy", so that
all the users, belonging to group "floppy", can read/write from/to disk.

mfg, Erik
