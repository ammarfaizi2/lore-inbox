Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbTFOHon (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 03:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbTFOHon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 03:44:43 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:41738 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261994AbTFOHom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 03:44:42 -0400
Subject: Re: 2.5.70-mm9
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Diego Calleja =?ISO-8859-1?Q?Garc=EDa?= <diegocg@teleline.es>
Cc: Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030615031421.1ed6640a.diegocg@teleline.es>
References: <20030613013337.1a6789d9.akpm@digeo.com>
	 <20030615031421.1ed6640a.diegocg@teleline.es>
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1055663908.631.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 15 Jun 2003 09:58:29 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-15 at 03:14, Diego Calleja García wrote:
> On Fri, 13 Jun 2003 01:33:37 -0700
> Andrew Morton <akpm@digeo.com> wrote:
> 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm9/
> 
> 
> I had the following messages: (ide, ext3 without any option, SMP, AS, JBD
> debugging enabled):
> 
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
>     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
> hda: Maxtor 6Y060L0, ATA DISK drive
> anticipatory scheduling elevator
> [...]
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> [...]
> EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda5, internal journal
> [...]
> 
> __mark_inode_dirty: this cannot happen
> __mark_inode_dirty: this cannot happen
> __mark_inode_dirty: this cannot happen
> __mark_inode_dirty: this cannot happen
> PPP: VJ decompression error
> PPP: VJ decompression error
> PPP: VJ decompression error
> __mark_inode_dirty: this cannot happen
> __mark_inode_dirty: this cannot happen
> __mark_inode_dirty: this cannot happen
> __mark_inode_dirty: this cannot happen
> __mark_inode_dirty: this cannot happen
> __mark_inode_dirty: this cannot happen
> invalid via82xx_cur_ptr, using last valid pointer
> invalid via82xx_cur_ptr, using last valid pointer
> invalid via82xx_cur_ptr, using last valid pointer
> PPP: VJ decompression error

The "__mark_inode_dirty" message is a deugging leftofer from Andrew that
is spit out the first time the machine starts swapping out. You can
safely ignore it.

