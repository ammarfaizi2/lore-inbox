Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbTEZWi6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 18:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbTEZWZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 18:25:19 -0400
Received: from web41511.mail.yahoo.com ([66.218.93.94]:55164 "HELO
	web41511.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262313AbTEZWOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 18:14:06 -0400
Message-ID: <20030526222718.81229.qmail@web41511.mail.yahoo.com>
Date: Mon, 26 May 2003 15:27:18 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: Re: 'fscope': a new debugging tool
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorted output from 'fscope -func=do_mmap_pgoff':

do_mmap_pgoff do_mmap2 old_mmap old_mmap_i386
do_mmap_pgoff do_mmap2 sys_mmap2
do_mmap_pgoff do_mmap aio_setup_ring ioctx_alloc sys_io_setup
do_mmap_pgoff do_mmap elf_map load_elf_binary
do_mmap_pgoff do_mmap elf_map load_elf_interp load_elf_binary
do_mmap_pgoff do_mmap i810_map_buffer i810_dma_get_buffer i810_getbuf
do_mmap_pgoff do_mmap i830_map_buffer i830_dma_get_buffer i830_getbuf
do_mmap_pgoff do_mmap load_aout_binary
do_mmap_pgoff do_mmap load_aout_library
do_mmap_pgoff do_mmap load_elf_binary
do_mmap_pgoff do_mmap load_elf_library
do_mmap_pgoff do_mmap load_flat_binary
do_mmap_pgoff do_mmap map_som_binary load_som_binary
do_mmap_pgoff do_mmap qcntl_ioctl shmiq_qcntl_ioctl
do_mmap_pgoff do_mmap sgi_graphics_ioctl
do_mmap_pgoff do_mmap sys_shmat sys_ipc

