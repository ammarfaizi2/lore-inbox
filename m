Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269639AbTHSKJY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 06:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269646AbTHSKJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 06:09:24 -0400
Received: from smtp0.libero.it ([193.70.192.33]:13452 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S269639AbTHSKJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 06:09:22 -0400
Subject: Re: 2.6.0-test3-mm3
From: Flameeyes <daps_mls@libero.it>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <20030819013834.1fa487dc.akpm@osdl.org>
References: <20030819013834.1fa487dc.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1061287775.5995.7.camel@defiant.flameeyes>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 19 Aug 2003 12:09:36 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-19 at 10:38, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test3/2.6.0-test3-mm3/

there's a problem with make xconfig:

defiant:/usr/src/linux-2.6.0-test3-mm3# make xconfig
  CC      scripts/empty.o
  MKELF   scripts/elfconfig.h
  HOSTCC  scripts/file2alias.o
  HOSTCC  scripts/modpost.o
  HOSTLD  scripts/modpost
make[1]: *** No rule to make target `scripts/kconfig/qconf.c', needed by
`scripts/kconfig/qconf'.  Stop.
make: *** [xconfig] Error 2


also, the ACPI entries seems vanished in the .config, and the menu is
not accessible.
With the old 2.6.0-test3-mm2 no problem at all.

-- 
Flameeyes <dgp85@users.sf.net>

