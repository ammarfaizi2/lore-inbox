Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbWFZA7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWFZA7P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 20:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbWFZA6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 20:58:51 -0400
Received: from terminus.zytor.com ([192.83.249.54]:13711 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964969AbWFZA6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:58:16 -0400
Date: Sun, 25 Jun 2006 17:57:58 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 02/43] Remove root-mounting code from the kernel.
Message-Id: <klibc.200606251757.02@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove root-mounting code from the kernel.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit a2faf9b56a04fc16ef2a8a8e42e91601cae1dc75
tree 96aab2efedb4893e338b3e4954ecdfb2637ddd21
parent 646e16312efb438f6e1ea58bdb1d9afad9477933
author H. Peter Anvin <hpa@zytor.com> Sun, 12 Feb 2006 20:44:56 -0800
committer H. Peter Anvin <hpa@zytor.com> Sun, 18 Jun 2006 18:45:26 -0700

 arch/i386/kernel/setup.c   |    9 
 arch/x86_64/kernel/setup.c |    8 
 init/Makefile              |    8 
 init/do_mounts.c           |  433 -------------
 init/do_mounts.h           |   91 ---
 init/do_mounts_devfs.c     |  137 ----
 init/do_mounts_initrd.c    |  125 ----
 init/do_mounts_md.c        |  286 --------
 init/do_mounts_rd.c        |  429 -------------
 init/initramfs.c           |    7 
 init/main.c                |   33 -
 net/ipv4/Makefile          |    1 
 net/ipv4/ipconfig.c        | 1510 --------------------------------------------
 13 files changed, 13 insertions(+), 3064 deletions(-)

Patch suppressed due to size (81 K), available at:
http://www.kernel.org/pub/linux/kernel/people/hpa/klibc-patchset/02-remove-root-mounting-code-from-the-kernel-.patch
