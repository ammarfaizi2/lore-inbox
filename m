Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277633AbRJHXsw>; Mon, 8 Oct 2001 19:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277631AbRJHXsg>; Mon, 8 Oct 2001 19:48:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32903 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277632AbRJHXsK>;
	Mon, 8 Oct 2001 19:48:10 -0400
Date: Mon, 08 Oct 2001 16:46:29 -0700 (PDT)
Message-Id: <20011008.164629.88474756.davem@redhat.com>
To: dwmw2@infradead.org
Cc: frival@zk3.dec.com, paulus@samba.org, Martin.Bligh@us.ibm.com,
        alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, jay.estabrook@compaq.com,
        rth@twiddle.net
Subject: Re: [PATCH] change name of rep_nop 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15384.1002584524@redhat.com>
In-Reply-To: <13962.1002580586@redhat.com>
	<14658.1002582388@redhat.com>
	<15384.1002584524@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Woodhouse <dwmw2@infradead.org>
   Date: Tue, 09 Oct 2001 00:42:04 +0100

   But x86 isn't particularly interesting - it'd be useful to have a 
   flush_dcache_range() which actually works across other architectures anyway.
   
The memory technology device case is weird, give it a solution
such as "asm/memdev.h".

   > Regardless, the purpose of the cachetlb.txt interfaces is for the
   > generic VM subsystem of the kernel.  Nothing more. 
   
   So they should probably have less misleading names, perchance including the
   letter 'v' and the letter 'm' somewhere? And they should _certainly_ have
   less misleading documentation. :)

Why?  find_get_page says nothing about "page cache", but people
understand that is what it is used for.

The documention should be more specific, thats all.

Franks a lot,
David S. Miller
davem@redhat.com
