Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265654AbTFXEF5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 00:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265655AbTFXEF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 00:05:57 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:27540 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S265654AbTFXEFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 00:05:55 -0400
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.73] restore UP spinlock workaround for gcc-2.95.3
References: <200306231348.h5NDm76X007502@harpo.it.uu.se>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 24 Jun 2003 13:19:21 +0900
In-Reply-To: <200306231348.h5NDm76X007502@harpo.it.uu.se>
Message-ID: <buo65mw3y5y.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also on the v850, a usable gcc-3.x is a relatively recent thing, so I
still use gcc-2.x for most things -- and without the spinlock
workaround, gcc-2.x for the v850 crashes.  Perhaps other archs also have
similar issues (not everything is as well-supported as i386!).

Given that the spinlock workaround is an extremely small and isolated
piece of code, there doesn't really seem to be benefit to removing it,
so Linus, please apply Mikael's patch to restore the workaround.

Thanks,

-Miles
-- 
`Life is a boundless sea of bitterness'
