Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264264AbRFFXoU>; Wed, 6 Jun 2001 19:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264263AbRFFXoK>; Wed, 6 Jun 2001 19:44:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54923 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261482AbRFFXn6>;
	Wed, 6 Jun 2001 19:43:58 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15134.49211.159673.522020@pizda.ninka.net>
Date: Wed, 6 Jun 2001 16:43:55 -0700 (PDT)
To: Ben Greear <greearb@candelatech.com>
Cc: "La Monte H.P. Yarroll" <piggy@em.cig.mot.com>,
        "Matt D. Robinson" <yakker@alacritech.com>,
        linux-kernel@vger.kernel.org, sctp-developers-list@cig.mot.com
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table
In-Reply-To: <3B1EC74D.6C720537@candelatech.com>
In-Reply-To: <200106051659.LAA20094@em.cig.mot.com>
	<3B1E5CC1.553B4EF1@alacritech.com>
	<15134.42714.3365.32233@theor.em.cig.mot.com>
	<15134.43914.98253.998655@pizda.ninka.net>
	<3B1EC74D.6C720537@candelatech.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ben Greear writes:
 > Then again, maybe someone has a reason to use a different
 > TCP stack, ie to support something like a high-availiblity stack
 > between two different machines...

Feel free to implement this and send me patches :-)

 > Why would you be scared of a proprietary  TCP stack?  If Open Source
 > is so much better (and I believe it is), then there would be nothing
 > to lose.  And if the new stack helped a small subset of people who would
 > otherwise have an even sorrier life implementing it on some other
 > platform, then that is better, right?

It's not an issue of scared or not scared.  It's an issue of what
Linus chooses to allow people to do with his kernel.  This is one of
the main reasons many of us even began to work on the Linux kernel,
because we knew our work could not be compromised in such a way.

And my current understanding is that allowing proprietary
reimplementations of the VM, VFS, and core networking, is not one of
the things which is allowed.

Later,
David S. Miller
davem@redhat.com
