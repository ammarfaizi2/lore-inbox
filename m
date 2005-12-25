Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbVLYUOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbVLYUOZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 15:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbVLYUOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 15:14:25 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:31687 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750903AbVLYUOY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 15:14:24 -0500
Date: Sun, 25 Dec 2005 20:14:23 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCHSET] 2.6.15-rc7-bird1
Message-ID: <20051225201423.GC27946@ftp.linux.org.uk>
References: <20051222101523.GP27946@ftp.linux.org.uk> <20051223093146.GT27946@ftp.linux.org.uk> <20051224095114.GU27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051224095114.GU27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Updated version:

ftp://ftp.linux.org.uk/pub/people/viro/patch-2.6.15-rc7-bird1.bz2

URL of splitup: same place, bird-mbox.

Mostly endianness stuff - finished off befs, killed the minor stuff that
had cropped up since the last (partial) endianness sweep in fs/*, handled
most of nfs and nfsd (that had uncovered several bugs in the latter).
Merged a patch from Alexey that should've been in -rc6-bird3, but had been
missed.

Changes since yesterday snapshot:
 
Al Viro:
[endianness annotations]
      befs: endianness annotations
      ext3 endianness annotations
      fs/fat endianness annotations
      hpfs endainness annotations
      smbfs endianness annotations
      isofs endianness annotations
      fs/partitions endianness annotations
      ufs endianness annotations
      sunrpc: xdr_stream->end also points to network-order data
      nfs: verifier is network-endian
      nfs4 endianness annotations
      nfs_common endianness annotations
      nfsd/vfs.c: endianness fixes
      nfsd4_truncate() bogus return value
      NFSERR_SERVERFAULT returned host-endian
      nfsd4_lock() returns bogus values to clients
      nfsd: nfserrno() endianness annotations
      nfsfh simple endianness annotations
      nfsd: misc endianness annotations
      nfsd: vfs.c endianness annotations
      nfsd: NFSv3 endianness annotations
      nfsd: NFSv2 endianness annotations
      nfsd: NFS4 endiannness annotations
      nfsd: nfs_replay_me
[m68k]
      m68k: fix PIO case in esp
[misc]
      isdn: amd7930 is blatantly broken (half-merged?), marked broken in Kconfig

Alexey Dobriyan:
      drivers/pcmcia/cistpl.c: fix endian warnings
