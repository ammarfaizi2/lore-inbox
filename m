Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265517AbSKVUNU>; Fri, 22 Nov 2002 15:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbSKVUNT>; Fri, 22 Nov 2002 15:13:19 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:19174 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S265517AbSKVUNS>; Fri, 22 Nov 2002 15:13:18 -0500
Date: Fri, 22 Nov 2002 15:21:28 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.20-rc3
Message-ID: <Pine.LNX.4.44L.0211221520230.22247-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Finally, here goes -rc3.



Summary of changes from v2.4.20-rc2 to v2.4.20-rc3
============================================

<akpm@digeo.com>:
  o Change mark_dirty_kiobuf() to use set_page_dirty() instead of SetPageDirty(). The latter fails to move onto mapping->dirty_pages(), which breaks filemap_fdatasync()
  o Writeout directory blocks synchronously in case of sync mount

<hch@lst.de>:
  o update kbuild/makefiles.txt to match reality

<lee@compucrew.com>:
  o Fix typo in mk712 driver

<marcelo@freak.distro.conectiva>:
  o Changed EXTRAVERSION to -rc3
  o Fix typo in vmalloc leak fix
  o Fixup pci_alloc_consistent with 64bit DMA masks on i386

Adrian Bunk <bunk@fs.tum.de>:
  o Fix Intermezzo compilation

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o makefiles for 2.4.20-rc* to build amd76x_pm right

Dave Jones <davej@suse.de>:
  o Plug leak in get_vm_area()

David S. Miller <davem@nuts.ninka.net>:
  o [TG3]: Use spin_lock_irq{save,restore} on tx_lock

David Woodhouse <dwmw2@infradead.org>:
  o JFFS2 corruption/deadlock fix

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o PCI transparent bridge detection fix

Jens Axboe <axboe@suse.de>:
  o Fix SCSI I/O performance problems introduced in early 2.4.20

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o ISDN: Fix error path in isdn_ppp.c

Rik van Riel <riel@conectiva.com.br>:
  o Only zero successfully handled blocks in prepare_write()

tmcreynolds@nvidia.com <TMcReynolds@nvidia.com>:
  o Add support for newer nForce chipset

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Fix NFS client problem





