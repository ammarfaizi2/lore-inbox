Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265506AbTAZAX5>; Sat, 25 Jan 2003 19:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265612AbTAZAX5>; Sat, 25 Jan 2003 19:23:57 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:17873 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S265506AbTAZAX4>;
	Sat, 25 Jan 2003 19:23:56 -0500
Date: Sun, 26 Jan 2003 01:33:09 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCHSET] Linux 2.4.21-pre3-jam3
Message-ID: <20030126003309.GG1507@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

Just to announce a new release, with some updates and novelties
(important ones, aic and epoll...)
As usual:

http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.21-pre3-jam3.tar.bz2
http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.21-pre3-jam3/

NOTE: there is anew version of bproc, but I could not update it 'cause
the tarball in bproc.sf.net is corrupted...

Changelog:
- aa updated to -pre3-aa1
- highpage_init integrated in -aa
- killed cd-read-audio-dma, because it was giving too much oopses...
- 08-e100-hw-init.bz2
    Fix hard reset of controller in some boards.
    Author: scott.feldman@intel.com 
- 18-fat-fdmode.bz2
    Add mount flags for file (fmode=...) and dir (dmode=...) in vfat fs.
    Author: Paul Evans <nerd@freeuk.com>
- 32-epoll-0.61.bz2
    Improved polling interface via sys_epoll call. Faster, lighter and
    more scalable.
    Author: Davide Libenzi <davidel@xmailserver.org>
- 33-epoll-smbfs
    Fix for smbfs.
- 37-ext3-scheduling-storm.bz2
    Fixes an inefficiency and potential system lockup in ext3 filesystem.
    Anyone who is using tasks which have realtime scheduling policy on ext3
    systems should apply this change.
    Author: Andrew Morton <akpm@digeo.com>
- 50-aic-20030122.bz2
    AIC 7xxx (upto U160,update) and 79xx (U320,new) scsi drivers.
    Versions: aic7xxx-6.2.28, aic79xx-1.3.0
    Author: Justin T. Gibbs <gibbs@scsiguy.com> 
    URL: http://people.freebsd.org/~gibbs/linux
- 55-ide-readahead.bz2
    Fix file_readahead setting in ide-cd and ide-floppy which
    assumed read-ahead values are kept as bytes.
    Author: Andrey Borzenkov <arvidjaar@mail.ru>
- 75-bttv-0.7.102.bz2
  76-bttv-0.7.102-doc.bz2
  77-bttv-0.7.102-tuner.bz2
  78-bttv-0.7.100-bt832.bz2
  79-bttv-0.7.102-i2c.bz2
    BTTV updates.
    Author: Gerd Knorr <kraxel@bytesex.org>
    URL: http://bytesex.org/bttv/

Enjoy !!

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre3-jam3 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-4mdk))
