Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278388AbRJMUKn>; Sat, 13 Oct 2001 16:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278390AbRJMUKe>; Sat, 13 Oct 2001 16:10:34 -0400
Received: from adsl-216-102-91-127.dsl.snfc21.pacbell.net ([216.102.91.127]:53777
	"EHLO ns1.serialhacker.net") by vger.kernel.org with ESMTP
	id <S278388AbRJMUKU>; Sat, 13 Oct 2001 16:10:20 -0400
Date: Sat, 13 Oct 2001 13:10:49 -0700
From: Drew Bertola <drew@drewb.com>
To: linux-kernel@vger.kernel.org
Subject: UFS partitions + 2.4.9
Message-ID: <20011013131049.A20572@drewb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please reply directly since I'm no longer subscribed]

I have not been able to successfully mount a ufs partition.  I've been
pouring through as much info as I can dig up on this.  The most
revealing info I find points to a broken ufs module.  Is that the
case?  To be honest, this is the first time I've had to mount a
FreeBSD UFS partition and this could all be user error.

Specifically, I've done this:

# mount -t ufs -o ufstype=44bsd /dev/hdc7 /mnt/ufs/
mount: wrong fs type, bad option, bad superblock on /dev/hdc7,
       or too many mounted file systems

This does load the ufs module (as confirmed by lsmod).

fdisk shows:

Command (m for help): p

Disk /dev/hdc: 16 heads, 63 sectors, 39704 cylinders
Units = cylinders of 1008 * 512 bytes

8 partitions:
#       start       end      size     fstype   [fsize bsize   cpg]
  a:        1         7*        6*    4.2BSD     1024  8192    16
  b:        7*       72*       65*      swap
  c:        1      2492*     2491*    unused        0     0
  e:       72*       75*        2*    4.2BSD     1024  8192    16
  f:       75*     2492*     2416*    4.2BSD     1024  8192    16


Any help would be appreciated.


-- 
Drew Bertola  | Send a text message to my pager or cell ... 
              | http://jpager.com/Drew

Linux 10th Anniversary Picnic/BBQ - visit http://linux10.org
