Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265154AbSLBGMk>; Mon, 2 Dec 2002 01:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbSLBGMk>; Mon, 2 Dec 2002 01:12:40 -0500
Received: from pizda.ninka.net ([216.101.162.242]:24767 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265154AbSLBGMj>;
	Mon, 2 Dec 2002 01:12:39 -0500
Date: Sun, 01 Dec 2002 22:17:39 -0800 (PST)
Message-Id: <20021201.221739.22504898.davem@redhat.com>
To: sfr@canb.auug.org.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, anton@samba.org,
       ak@muc.de, davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org,
       willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021202155729.55949b10.sfr@canb.auug.org.au>
References: <Pine.LNX.4.44.0212011047440.12964-100000@home.transmeta.com>
	<1038804400.4411.4.camel@rth.ninka.net>
	<20021202155729.55949b10.sfr@canb.auug.org.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stephen Rothwell <sfr@canb.auug.org.au>
   Date: Mon, 2 Dec 2002 15:57:29 +1100
   
   On 01 Dec 2002 20:46:40 -0800 "David S. Miller" <davem@redhat.com> wrote:
   >
   > On Sun, 2002-12-01 at 10:54, Linus Torvalds wrote:
   > > But if the file is in kernel/xxxx, it 
   > > will be noticed - at least as well as it would be if it was uglifying 
   > > regular files with #ifdef's.
   > 
   > Ok, this I accept.
   
   So, does this mean you are happy if I produce patches with kernel/compat.c
   in them rather than code #ifdef'ed into the mainline? This, of course,
   begs the question of whether it should all go into kernel/compat.c or
   should there be an fs/compat.c, mm/compat.c ...

Yes, I'm fine with it.

My personal take on the next issue is that I do believe we should
have fs/compat.c et al.

But for you initial patch, just put it into kernel/compat.c
