Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310850AbSCSXtG>; Tue, 19 Mar 2002 18:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310835AbSCSXtB>; Tue, 19 Mar 2002 18:49:01 -0500
Received: from pizda.ninka.net ([216.101.162.242]:59079 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S310850AbSCSXsi>;
	Tue, 19 Mar 2002 18:48:38 -0500
Date: Tue, 19 Mar 2002 15:45:02 -0800 (PST)
Message-Id: <20020319.154502.18227426.davem@redhat.com>
To: lm@bitmover.com
Cc: pavel@suse.cz, davej@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Bitkeeper licence issues
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020319154436.N14877@work.bitmover.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Larry McVoy <lm@bitmover.com>
   Date: Tue, 19 Mar 2002 15:44:36 -0800
   
   Hey Dave, are you suggesting that no such exploits exist in Red Hat's 
   rpm system?  In order for that to be true, rpm would have to be making
   sure that each and every directory along any path that it writes is
   not writable except by priviledged users.  I just checked, it doesn't.

We should be using mktemp() to make temporary files, and if we don't
that is a bug and I'd ask you to please submit a bugzilla entry about
it if so because that would be a serious hole.
