Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbVATVLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVATVLa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 16:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVATVL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 16:11:29 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43679 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261951AbVATVKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 16:10:06 -0500
Date: Thu, 20 Jan 2005 21:59:50 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH][RFC] swsusp: speed up image restoring on x86-64
Message-ID: <20050120205950.GF468@openzaurus.ucw.cz>
References: <200501202032.31481.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501202032.31481.rjw@sisk.pl>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following patch speeds up the restoring of swsusp images on x86-64
> and makes the assembly code more readable (tested and works on AMD64).  It's
> against 2.6.11-rc1-mm1, but applies to 2.6.11-rc1-mm2.  Please consifer for applying.

Can you really measure the speedup? If you want cheap way to speed it up,
kill cr3 manipulation.

Anyway, this is likely to clash with hugang's work; I'd prefer this not to be applied.

				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

