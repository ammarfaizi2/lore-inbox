Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262977AbTCWIvk>; Sun, 23 Mar 2003 03:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262980AbTCWIvk>; Sun, 23 Mar 2003 03:51:40 -0500
Received: from pizda.ninka.net ([216.101.162.242]:53955 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262977AbTCWIvj>;
	Sun, 23 Mar 2003 03:51:39 -0500
Date: Sun, 23 Mar 2003 01:00:26 -0800 (PST)
Message-Id: <20030323.010026.18275919.davem@redhat.com>
To: sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, bcrl@redhat.com
Subject: Re: [PATCH][COMPAT] cleanups in net/compat.c and related files
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030318223919.4bceb9f5.sfr@canb.auug.org.au>
References: <20030318182935.0aa53710.sfr@canb.auug.org.au>
	<20030317.233337.76754195.davem@redhat.com>
	<20030318223919.4bceb9f5.sfr@canb.auug.org.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stephen Rothwell <sfr@canb.auug.org.au>
   Date: Tue, 18 Mar 2003 22:39:19 +1100

   On Mon, 17 Mar 2003 23:33:37 -0800 (PST) "David S. Miller" <davem@redhat.com> wrote:
   >
   > I'm saying to move this stuff to include/net/compat.h instead
   > of creating this new meaningless net/compat_socket.h file.
   
   OK, new version of patch.  This one creates include/net/compat.h
   and moves all the include/net/compat_socket.h stuff into it.
   
I'm fine with this, but I just tried to apply it and there were a ton
of rejects.  Can you rediff this against Linus's current tree and send
it to me?

Thank you.
