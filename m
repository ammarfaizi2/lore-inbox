Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280638AbRKJNcJ>; Sat, 10 Nov 2001 08:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280641AbRKJNcA>; Sat, 10 Nov 2001 08:32:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:7808 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280637AbRKJNbp>;
	Sat, 10 Nov 2001 08:31:45 -0500
Date: Sat, 10 Nov 2001 05:31:16 -0800 (PST)
Message-Id: <20011110.053116.41632367.davem@redhat.com>
To: matthew@hairy.beasts.org
Cc: jjs@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: Networking: repeatable oops in 2.4.15-pre2
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0111101148250.20176-100000@sphinx.mythic-beasts.com>
In-Reply-To: <3BECC7F4.A9EF9E6B@pobox.com>
	<Pine.LNX.4.33.0111101148250.20176-100000@sphinx.mythic-beasts.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Matthew Kirkwood <matthew@hairy.beasts.org>
   Date: Sat, 10 Nov 2001 11:53:11 +0000 (GMT)

   On Fri, 9 Nov 2001, J Sloan wrote:
   
   > I have been running the 2.4.15-pre kernels and
   > have found an interesting oops. I can reproduce
   > it immediately, and reliably, just by issuing an ssh
   > command (as a normal user).
   
   I'm seeing the same thing on my gateway, though I haven't
   yet found my serial cable to get the oops translated.  I
   am back to 2.4.10 for now.
   
Just back out the netfilter changes in 2.4.15-pre1, that
is the cause.

Franks a lot,
David S. Miller
davem@redhat.com
