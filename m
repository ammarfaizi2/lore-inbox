Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUDNUQS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbUDNUQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:16:09 -0400
Received: from linux-bt.org ([217.160.111.169]:29583 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S261628AbUDNUQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:16:02 -0400
Subject: Compile problem with sparc64
From: Marcel Holtmann <marcel@holtmann.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: SPARC Linux Mailing List <sparclinux@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1081973754.3372.5.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 14 Apr 2004 22:15:55 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the changeset

ChangeSet@1.1713.27.238, 2004-04-12 13:31:10-07:00, akpm@osdl.org
  [PATCH] binfmt_elf.c fix for 32-bit apps with large bss

causes this compile problem on sparc64

  CC      arch/sparc64/kernel/binfmt_elf32.o
In file included from arch/sparc64/kernel/binfmt_elf32.c:154:
fs/binfmt_elf.c: In function `load_elf_interp':
fs/binfmt_elf.c:369: warning: comparison is always false due to limited range of data type
fs/binfmt_elf.c: In function `load_elf_binary':
fs/binfmt_elf.c:780: warning: comparison is always false due to limited range of data type

Regards

Marcel


