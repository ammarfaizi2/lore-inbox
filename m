Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267049AbTBIIA4>; Sun, 9 Feb 2003 03:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267070AbTBIIA4>; Sun, 9 Feb 2003 03:00:56 -0500
Received: from webmail11.cac.psu.edu ([128.118.1.220]:35496 "EHLO
	webmail11.cac.psu.edu") by vger.kernel.org with ESMTP
	id <S267049AbTBIIAz>; Sun, 9 Feb 2003 03:00:55 -0500
Date: Sun, 9 Feb 2003 03:10:38 -0500 (EST)
Message-Id: <200302090810.DAA10550@webmail11.cac.psu.edu>
To: linux-kernel@vger.kernel.org
Subject: problems after ext3 recovery
From: "MATTHEW ADAM GERGINSKI" <mag357@psu.edu>
X-Mailer: Penn State WebMail
X-Originating-IP: 66.71.10.5
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Wondering if this is a kernel-related problem... upon boot, the filesystem is
mounted as readonly, and it says that read-write will be enabled during the
recovery process.  The recovery complete's successfully, but then it does not
remount as read-write, it mounts as readonly, as shown byt he output here:

EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly
Mounted devfs on /dev
Freeing unused kernel memory: 72k freed
INIT: version 2.84 booting

/sbin/rc: /var/state/init.d/softlevel: Read-only file system
install: cannot create directory '/var/state/init.d/failed' : Read-only file
system
install: cannot create directory '/var/state/init.d/softscripts.new' : Read-only
file system


>From then on, it tries to create symlinks in those two directories to a bunch of
stuff in /etc.... but... they don't exist, so it doesn't work....

Wondering is this is an ext3 or another kernel related problem.  If so, I
thought I should bring it to your attention. Also, any advice on how to fix
this would be grrrrrreat.  I am running the 2.4.19 kernel, and have since tried
to boot with a 2.5.52 kernel, and have gotten the same results.

Thanks,
    Matt

