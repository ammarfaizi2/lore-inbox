Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbTEHLay (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 07:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTEHLay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 07:30:54 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20105 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261328AbTEHLax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 07:30:53 -0400
Date: Thu, 08 May 2003 03:35:34 -0700 (PDT)
Message-Id: <20030508.033534.74727769.davem@redhat.com>
To: arnd@arndb.de
Cc: pavel@ucw.cz, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305080150.10697.arnd@arndb.de>
References: <200305072113.07004.arnd@arndb.de>
	<20030507.111245.25138161.davem@redhat.com>
	<200305080150.10697.arnd@arndb.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnd Bergmann <arnd@arndb.de>
   Date: Thu, 8 May 2003 01:50:10 +0200
   
   I checked the numbers that are in arch/sparc64/kernel/ioctl32.o
   and found none that uses more than 9 bits for the size field,

I know that we had to change our sparc ioctl macro definitions a few
months ago to accomodate some ioctl that wanted more bits.

It isn't a theoretical problem.
