Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266728AbSL3GMv>; Mon, 30 Dec 2002 01:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266730AbSL3GMv>; Mon, 30 Dec 2002 01:12:51 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:24745 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266728AbSL3GMv>;
	Mon, 30 Dec 2002 01:12:51 -0500
Date: Mon, 30 Dec 2002 17:19:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Cc: anton@samba.org, "David S. Miller" <davem@redhat.com>, ak@muc.de,
       davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org,
       willy@debian.org
Subject: [PATCH][COMPAT] Eliminate the rest of the __kernel_..._t32 typedefs
 0/7
Message-Id: <20021230171959.63ea2d5d.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.7 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The following patches (one for each affected architecture) remove the
last of the __kernel_..._t32 typedefs.  These patches are relative to
2.5.53 and there are now only a couple of cases where none of the
compatibility syscall infrastructure has been integrated.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
