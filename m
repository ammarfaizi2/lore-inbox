Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310750AbSCSXcZ>; Tue, 19 Mar 2002 18:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310740AbSCSXcV>; Tue, 19 Mar 2002 18:32:21 -0500
Received: from pizda.ninka.net ([216.101.162.242]:44487 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S310749AbSCSXbc>;
	Tue, 19 Mar 2002 18:31:32 -0500
Date: Tue, 19 Mar 2002 15:27:59 -0800 (PST)
Message-Id: <20020319.152759.06816290.davem@redhat.com>
To: lm@bitmover.com
Cc: pavel@suse.cz, davej@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Bitkeeper licence issues
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020319152502.J14877@work.bitmover.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Larry McVoy <lm@bitmover.com>
   Date: Tue, 19 Mar 2002 15:25:02 -0800

   Come on Pavel, in order to make this happen, you have to
   
   	a) run the installer as root
   	b) know the next pid which will be allocated
   	c) put the symlink in /tmp/installer$pid
   
Exploit: Make all 65535 $pid simlinks

It's very exploitable actually, and is similar in vein to
all the ancient mktemp stuff.
