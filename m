Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261325AbREQHkq>; Thu, 17 May 2001 03:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbREQHkg>; Thu, 17 May 2001 03:40:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54155 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261325AbREQHk2>;
	Thu, 17 May 2001 03:40:28 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15107.32873.596192.859985@pizda.ninka.net>
Date: Thu, 17 May 2001 00:40:25 -0700 (PDT)
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [What the...] sti() in device_init()
In-Reply-To: <Pine.GSO.4.21.0105170221000.27492-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0105170221000.27492-100000@weyl.math.psu.edu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alexander Viro writes:
 > 	Folks, what the hell is sti(); doing in device_init()?  It's
 > done _much_ earlier (before calibrate_delay(); in start_kernel())
 > and I don't see anything that would require repeating it...
 > 
 > 	Looks bogus for me... Linus?

I'm pretty sure it's an unnecessary turd, and you can safely remove
it.

My memory is foggy on this, but I think it was in fact necessary a
long long time ago.

Later,
David S. Miller
davem@redhat.com
