Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261630AbTCaNJ3>; Mon, 31 Mar 2003 08:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261631AbTCaNJ2>; Mon, 31 Mar 2003 08:09:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:44688 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261630AbTCaNJ1>;
	Mon, 31 Mar 2003 08:09:27 -0500
Date: Mon, 31 Mar 2003 05:17:18 -0800 (PST)
Message-Id: <20030331.051718.111107720.davem@redhat.com>
To: sfr@canb.auug.org.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, randolph@tausq.org,
       bcrl@redhat.com, anton@samba.org
Subject: Re: [PATCH][COMPAT] another net/compat fix -- for recvmsg
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030331181644.29a2bfc6.sfr@canb.auug.org.au>
References: <20030331181644.29a2bfc6.sfr@canb.auug.org.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stephen Rothwell <sfr@canb.auug.org.au>
   Date: Mon, 31 Mar 2003 18:16:44 +1000

   >From Randolph Chung, I got the following:
   
   "Here's another patch for the net/compat stuff... this touches two files:
  ...   
   The first I am pretty sure is correct (and pretty trivial). The second I
   am also pretty sure about, but not 100%.  Could you please have a look and
   see what you think.  If its OK, the please apply.
   
   I have modified Randolf's patch a little to complete remove
   put_compat_msg_controllen as it just degenerates.
   
I believe all are totally correct, patch applied.

Anton, please check to make sure this fixes your sshd problems
on ppc64, thanks.
