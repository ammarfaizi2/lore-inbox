Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135874AbREFV40>; Sun, 6 May 2001 17:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135875AbREFV4Q>; Sun, 6 May 2001 17:56:16 -0400
Received: from p3E9D32A0.dip.t-dialin.net ([62.157.50.160]:1775 "EHLO
	infinity.bzimage.de") by vger.kernel.org with ESMTP
	id <S135874AbREFV4G>; Sun, 6 May 2001 17:56:06 -0400
Date: Sun, 6 May 2001 23:54:26 +0200
From: Norbert Tretkowski <tretkowski@bzimage.de>
To: linux-kernel@vger.kernel.org
Subject: Re: XFS and Alan kernel tree
Message-ID: <20010506235426.A16127@infinity.bzimage.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010505230816.A31544@witch.underley.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010505230816.A31544@witch.underley.eu.org>; from underley@underley.eu.org on Sat, May 05, 2001 at 11:08:16PM +0200
Organization: <defunct>
Mail-Copies-To: never
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Daniel Podlejski <underley@underley.eu.org> wrote:
> I merge XFS witch Alan tree (2.4.4-ac5). It's seems to be stable.

ld -m elf_i386  -r -o fs.o open.o read_write.o devices.o file_table.o
buffer.o super.o block_dev.o stat.o exec.o pipe.o namei.o fcntl.o
ioctl.o readdir.o select.o fifo.o locks.o dcache.o inode.o attr.o
bad_inode.o file.o iobuf.o dnotify.o filesystems.o noquot.o ext_attr.o
noposix_acl.o binfmt_script.o binfmt_elf.o proc/proc.o
partitions/partitions.o ext2/ext2.o nls/nls.o
ld: cannot open noposix_acl.o: No such file or directory
make[2]: *** [fs.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.4-ac5-xfs/fs'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.4-ac5-xfs/fs'
make: *** [_dir_fs] Error 2


Norbert
