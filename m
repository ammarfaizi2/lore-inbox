Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268548AbUHLTZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268548AbUHLTZU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 15:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268673AbUHLTZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 15:25:20 -0400
Received: from pop.gmx.de ([213.165.64.20]:60079 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268550AbUHLTZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 15:25:15 -0400
X-Authenticated: #12437197
Date: Thu, 12 Aug 2004 22:25:35 +0300
From: Dan Aloni <da-x@colinux.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Generation of *.s files from *.S files in kbuild
Message-ID: <20040812192535.GA20953@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

Is the generation of *.s files from *.S files in the kernel
build system a wide spread phenomenon? As far as I can see
only vmlinux.lds.s is built that way in my default i386 config.

It causes problems when trying to cross-build a kernel on a 
file system that has case-insensitive filenames, or on a GNU
port that is case insensitive (such as Cygwin).

If anyone wondered, I'm trying to cross build a Linux kernel
on a Cygwin system using a Linux native toolchain, in order
to make development of the Windows port of coLinux easier
for some people.

-- 
Dan Aloni
da-x@colinux.org
