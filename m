Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275067AbRIYQQW>; Tue, 25 Sep 2001 12:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275084AbRIYQQM>; Tue, 25 Sep 2001 12:16:12 -0400
Received: from mail.delfi.lt ([213.197.128.86]:54792 "HELO
	mx-outgoing.delfi.lt") by vger.kernel.org with SMTP
	id <S275067AbRIYQP6>; Tue, 25 Sep 2001 12:15:58 -0400
Date: Tue, 25 Sep 2001 18:15:43 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re: all files are executable in vfat
To: Alexander Viro <viro@math.psu.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
In-Reply-To: <Pine.GSO.4.21.0109251207290.24321-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0109251207290.24321-100000@weyl.math.psu.edu>
X-Mailer: Mahogany, 0.64 'Sparc', compiled for Linux 2.4.7 i686
Message-Id: <20010925161622.0795B8F616@mail.delfi.lt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001 12:09:30 -0400 (EDT) Alexander Viro <viro@math.psu.edu> wrote:

AV> > All files are executable in vfat (kernel 2.4.10), although I have
AV> > /dev/hda1  /mnt/c   vfat   defaults,user,noexec,umask=0,quiet 0 0
AV> > in /etc/fstab. They were not in 2.4.7.
AV> 
AV> Really? Try to execute a binary from there.  cp /bin/ls /mnt/c && /mnt/c/ls

bash: /mnt/c/ls: Permission denied. But:
$ ls -l ls
-rwxrwxrwx    1 nerijus  nerijus     45724 Rgs 25 18:12 ls

The problem is, mc sees such files as executables and I cannot view
archives by pressing enter on them, instead mc tries to execute them.
Was this change intentional?

Regards,
Nerijus

