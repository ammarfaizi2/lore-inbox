Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291425AbSAaXrr>; Thu, 31 Jan 2002 18:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291430AbSAaXrh>; Thu, 31 Jan 2002 18:47:37 -0500
Received: from pizda.ninka.net ([216.101.162.242]:3200 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291425AbSAaXrV>;
	Thu, 31 Jan 2002 18:47:21 -0500
Date: Thu, 31 Jan 2002 15:45:47 -0800 (PST)
Message-Id: <20020131.154547.74749379.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: vandrove@vc.cvut.cz, torvalds@transmeta.com, garzik@havoc.gtf.org,
        linux-kernel@vger.kernel.org, paulus@samba.org, davidm@hpl.hp.com,
        ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E16WQYs-0003Ux-00@the-village.bc.nu>
In-Reply-To: <20020131.145904.41634460.davem@redhat.com>
	<E16WQYs-0003Ux-00@the-village.bc.nu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Thu, 31 Jan 2002 23:24:10 +0000 (GMT)

   > As a side note, this thing is so tiny (less than 4K on sparc64!) so
   > why don't we just include it unconditionally instead of having all
   > of this "turn it on for these drivers" stuff?
   
   Because 100 4K drivers suddenly becomes 0.5Mb.

However this isn't a driver, the crc library stuff is more akin to
"strlen()".  Are you suggesting to provide a CONFIG_STRINGOPS=n
too?  I wish you luck building that kernel :-)


