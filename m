Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261715AbSJQASH>; Wed, 16 Oct 2002 20:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261718AbSJQASH>; Wed, 16 Oct 2002 20:18:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17078 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261715AbSJQASF>;
	Wed, 16 Oct 2002 20:18:05 -0400
Date: Wed, 16 Oct 2002 17:16:26 -0700 (PDT)
Message-Id: <20021016.171626.112600105.davem@redhat.com>
To: rmk@arm.linux.org.uk
Cc: hugh@veritas.com, willy@debian.org, akpm@zip.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shmem missing cache flush
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021017011957.A9589@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0210170033320.1476-100000@localhost.localdomain>
	<20021016.165834.71112730.davem@redhat.com>
	<20021017011957.A9589@flint.arm.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Russell King <rmk@arm.linux.org.uk>
   Date: Thu, 17 Oct 2002 01:19:57 +0100
   
   I similarly wish that were so.  Any cleanups in this area are most
   welcome.  Alas m68k and sparc still use flush_page_to_ram().

I'd consider it more than rude to break this 5 days before
feature freeze. :-)

Put this at the top of the list of 2.7.x todo and let's not
forget it this time.
