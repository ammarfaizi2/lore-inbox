Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbTJWUJn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 16:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbTJWUIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 16:08:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12231 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261786AbTJWUIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 16:08:14 -0400
Date: Thu, 23 Oct 2003 22:00:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: John Mock <kd6pag@qsl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kill unneccessary debug printk
Message-ID: <20031023200022.GI643@openzaurus.ucw.cz>
References: <E1ABePM-0002dL-00@penngrove.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ABePM-0002dL-00@penngrove.fdns.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Actually, that 'printk' is useful.  As i understand it, the only way software
> suspend is going to work is that if the same video mode is used on resume as
> on booting.  If one uses "vga=ask", then one can 'dmesg | grep' to generate
> a proper string for 'lilo -R' (which i already do to make sure the correct
> kernel gets resumed during testing).  If i'm mistaken about needing to set
> VGA mode identically on resume, then i have no objection to removing the
> printk.

Oops, someone is using my debug printk :-(. I'll at least try
to merge it with some other msg, so it does not waste full
line.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

