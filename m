Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277777AbRJLRJW>; Fri, 12 Oct 2001 13:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277781AbRJLRJN>; Fri, 12 Oct 2001 13:09:13 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:15612 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S277777AbRJLRI7>;
	Fri, 12 Oct 2001 13:08:59 -0400
Date: Fri, 12 Oct 2001 10:09:29 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [patch] Wireless Extension update [second try]
Message-ID: <20011012100929.A20167@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

	I like to keep your tree and Alan's tree in sync, so would you
mind applying this patch to your kernel.

	It contains :
	o Define wireless device private ioctl range to avoid name
space collisions with stuff like 'mii-tools'. This is something I've
done at the rerquest of David Miller, and I would like this in so that
the various wireless driver can make the transitions early in 2.5.X.
	o Various benign update the wireless statistics to be more
802.11 compliant.

	I've regenerated this patch against 2.4.12 and fixed a
spelling mistake.
	Thanks in advance...

	Jean
