Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267125AbTBUEXl>; Thu, 20 Feb 2003 23:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267126AbTBUEXl>; Thu, 20 Feb 2003 23:23:41 -0500
Received: from pizda.ninka.net ([216.101.162.242]:41933 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267125AbTBUEXk>;
	Thu, 20 Feb 2003 23:23:40 -0500
Date: Thu, 20 Feb 2003 20:17:49 -0800 (PST)
Message-Id: <20030220.201749.75380162.davem@redhat.com>
To: neilb@cse.unsw.edu.au
Cc: ak@suse.de, linux-kernel@vger.kernel.org, aeb@cwi.nl
Subject: Re: sendmsg and IP_PKTINFO
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15957.41515.937965.343498@notabene.cse.unsw.edu.au>
References: <20030218.155651.108799644.davem@redhat.com.suse.lists.linux.kernel>
	<p73wujwy98p.fsf@amdsimf.suse.de>
	<15957.41515.937965.343498@notabene.cse.unsw.edu.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Neil Brown <neilb@cse.unsw.edu.au>
   Date: Fri, 21 Feb 2003 14:51:07 +1100
   
   As far as I can tell, control message are currently defined for:
      IPv4,
      IPv6,
      SOL_HCI - some bluetooth thing
      SOL_SOCKET (which don't seem to be clearly documented in socket(7))
   
Also, control messages are used for AF_UNIX to pass file descriptors
around.
