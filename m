Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVDBX3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVDBX3R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 18:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVDBX3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 18:29:17 -0500
Received: from mail.dif.dk ([193.138.115.101]:63395 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261343AbVDBX3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 18:29:13 -0500
Date: Sun, 3 Apr 2005 01:31:30 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com
Subject: Re: [2.6.11.6] Oops trying to remove module "bttv"
In-Reply-To: <20050402231737.GA4773@localhost>
Message-ID: <Pine.LNX.4.62.0504030127420.2525@dragon.hyggekrogen.localhost>
References: <20050402231737.GA4773@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Apr 2005, Jose Luis Domingo Lopez wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi all:
> 
> I am getting the following stack dump in the logs when I try to unload the
> "bttv" kernel module ("rmmod bttv" ends with SIGSEGV). I have tried with
> other kernel versions keeping "module-init-tools" version the same (Debian
> 3.1-rel-2), and realized that:
> - - 2.6.10-rc3-bk15: OK
> - - 2.6.11-rc-bk3: OK
> - - 2.6.11-rc3: FAILS
> - - 2.6.11.6: FAILS
> 
> So it seems the bug was introduced somewhere 2.6.11-rc-bk3 and 2.6.11-rc3.

Have you tried 2.6.12-rc1-bk5 or 2.6.12-rc1-mm4 to see if the bug has 
already been fixed ?

-- 
Jesper Juhl


