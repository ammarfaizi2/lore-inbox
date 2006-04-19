Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWDSHJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWDSHJu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 03:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWDSHJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 03:09:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:39828 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750703AbWDSHJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 03:09:50 -0400
Date: Wed, 19 Apr 2006 00:05:47 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.16.9
Message-ID: <20060419070547.GA31743@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.16.9 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.16.8 and 2.6.16.9, as it is small enough to do so.

The updated 2.6.16.y git tree can be found at:
 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile                        |    2 +-
 arch/i386/kernel/cpu/amd.c      |    2 ++
 arch/x86_64/kernel/process.c    |    8 ++++++--
 arch/x86_64/kernel/setup.c      |    4 ++++
 include/asm-i386/cpufeature.h   |    1 +
 include/asm-i386/i387.h         |   30 ++++++++++++++++++++++++++----
 include/asm-x86_64/cpufeature.h |    1 +
 include/asm-x86_64/i387.h       |   20 +++++++++++++++++++-
 8 files changed, 60 insertions(+), 8 deletions(-)

Summary of changes from v2.6.16.8 to v2.6.16.9
==============================================

Andi Kleen:
      i386/x86-64: Fix x87 information leak between processes (CVE-2006-1056)

Greg Kroah-Hartman:
      Linux 2.6.16.9

