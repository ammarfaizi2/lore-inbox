Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265559AbRGOBqV>; Sat, 14 Jul 2001 21:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265571AbRGOBqL>; Sat, 14 Jul 2001 21:46:11 -0400
Received: from dnscache.cbr.au.asiaonline.net ([210.215.8.100]:25987 "EHLO
	dnscache.cbr.au.asiaonline.net") by vger.kernel.org with ESMTP
	id <S265559AbRGOBqB>; Sat, 14 Jul 2001 21:46:01 -0400
Message-ID: <3B50F5B0.7058B30A@acm.org>
Date: Sun, 15 Jul 2001 11:45:20 +1000
From: Gareth Hughes <gareth.hughes@acm.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.6-ac3
In-Reply-To: <E15LVfl-0001fh-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> I've read the DRI 4.1 code. Its unreadable macro abuse.

Fair enough.  However, we now no longer have the same core DRM functions
copied-and-pasted into each individual driver, renamed to foo_* and
tweaked to add AGP support.  If something needs fixing in the core DRM
stuff, it can be done in one place now, and all drivers will see the
fix.

Oh, and at least the new MGA driver is stable.

-- Gareth
