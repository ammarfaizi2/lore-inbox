Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318327AbSHSLxL>; Mon, 19 Aug 2002 07:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318473AbSHSLxL>; Mon, 19 Aug 2002 07:53:11 -0400
Received: from dp.samba.org ([66.70.73.150]:34434 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S318327AbSHSLxK>;
	Mon, 19 Aug 2002 07:53:10 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15712.55881.945932.782684@argo.ozlabs.ibm.com>
Date: Mon, 19 Aug 2002 21:45:13 +1000 (EST)
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH] convert aty128fb to new framebuffer API
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have converted aty128fb.c in current 2.5 to the new framebuffer API,
imported various fixes from the 2.4 PPC tree (fixes for running at
15bpp and 16bpp, plus support for sleeping (suspending) on
powerbooks), and reindented it to 8-column tabs.  Since the patch is
rather large, I didn't include it here.  It is available at
ftp://ftp.samba.org/pub/paulus/aty128.patch instead.

Paul.
