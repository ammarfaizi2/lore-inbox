Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291146AbSBLPxL>; Tue, 12 Feb 2002 10:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290276AbSBLPxD>; Tue, 12 Feb 2002 10:53:03 -0500
Received: from pizda.ninka.net ([216.101.162.242]:16004 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291146AbSBLPwt>;
	Tue, 12 Feb 2002 10:52:49 -0500
Date: Tue, 12 Feb 2002 07:50:51 -0800 (PST)
Message-Id: <20020212.075051.14974554.davem@redhat.com>
To: rmk@arm.linux.org.uk
Cc: stodden@in.tum.de, groudier@free.fr, alan@lxorguk.ukuu.org.uk,
        zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: pci_pool reap?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020212154816.E31425@flint.arm.linux.org.uk>
In-Reply-To: <20020211.184412.35663889.davem@redhat.com>
	<1013528224.2240.245.camel@bitch>
	<20020212154816.E31425@flint.arm.linux.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Russell King <rmk@arm.linux.org.uk>
   Date: Tue, 12 Feb 2002 15:48:16 +0000

   If you're really interested in the outcome, please examine the lkml
   archives.

The conclusion we came to is that there is no reason you can't do the
remapping from interrupts on ARM and propagate the GFP_ATOMIC
properly as well.  Right?

Or is this another "I'm not going to make the change until it
is required of me" situation?  If so I'll just make it so :-)
