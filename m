Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbTEHT5g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 15:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbTEHT5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 15:57:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50573 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262066AbTEHT5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 15:57:36 -0400
Date: Thu, 08 May 2003 13:09:51 -0700 (PDT)
Message-Id: <20030508.130951.67904715.davem@redhat.com>
To: pavel@ucw.cz
Cc: bcollins@debian.org, hch@infradead.org, arnd@arndb.de,
       linux-kernel@vger.kernel.org
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030508200630.GC2308@atrey.karlin.mff.cuni.cz>
References: <20030508193430.GC933@elf.ucw.cz>
	<20030508192730.GX679@phunnypharm.org>
	<20030508200630.GC2308@atrey.karlin.mff.cuni.cz>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pavel Machek <pavel@ucw.cz>
   Date: Thu, 8 May 2003 22:06:30 +0200
   
   Really? I thought sparc64 has no real 64-bit userland?
   
Wrong.  We use 32-bit binaries by default because they're
more efficient.
