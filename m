Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310324AbSCLBqK>; Mon, 11 Mar 2002 20:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310332AbSCLBqE>; Mon, 11 Mar 2002 20:46:04 -0500
Received: from defiant.secureone.com.au ([203.55.158.195]:13984 "EHLO
	defiant.secureone.com.au") by vger.kernel.org with ESMTP
	id <S310309AbSCLBpr>; Mon, 11 Mar 2002 20:45:47 -0500
Posted-Date: Tue, 12 Mar 2002 11:45:34 +1000
X-URL: SecureONE SecureSentry - http://www.secureone.com.au/
Message-ID: <05ca01c1c968$10358810$0f01000a@brisbane.hatfields.com.au>
Reply-To: "Andrew Hatfield" <lkml@secureone.com.au>
From: "Andrew Hatfield" <lkml@secureone.com.au>
To: <meusel@codixx.de>, <linux-kernel@vger.kernel.org>
In-Reply-To: <E16j1Z6-0002xf-00@the-village.bc.nu> <02031109444400.00601@huschki> <20020311084741.GC311@matchmail.com> <02031110223301.00601@huschki>
Subject: Re: Ext2/3 uid/gid support
Date: Tue, 12 Mar 2002 11:48:52 +1000
Organization: SecureONE
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chgrp /dev/fd0 floppy


  --

  Andrew Hatfield
  SecureONE - http://www.secureone.com.au/
  President - South East Brisbane Linux Users Group  http://www.seblug.org/

  Kernel work available at http://development.secureone.com.au/kernel/

----- Original Message -----
From: "Erik Meusel" <meusel@codixx.de>
To: <linux-kernel@vger.kernel.org>
Sent: Monday, March 11, 2002 7:22 PM
Subject: Re: Ext2/3 uid/gid support


> Am Montag, 11. März 2002 09:47 schrieb Mike Fedyk:
> > On Mon, Mar 11, 2002 at 09:44:44AM +0100, Erik Meusel wrote:
> > > Hi.
> > >
> > > Just one little question:
> > >
> > > Why do ext2 and ext3 not support mount options uid and gid as all the
> > > other  filesystems do?
> >
> > because they have uid and gid within the filesystem itself for
directories,
> > files, pipes, etc stored in the inodes of the fs.  Same with any other
> > posix filesystem (which vfat, iso9660(not counting rockridge), hfs, etc
are
> > *not*).
> Sure.
> The reason why I ask is, I have two linux stations and I want to use ext2
> for the floppy disks to save space for fat vfat and so on. Now it would
> be nice to automatically mount my floppies with group "floppy", so that
> all the users, belonging to group "floppy", can read/write from/to disk.
>
> mfg, Erik
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

