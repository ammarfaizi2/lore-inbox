Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270085AbUJSTAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270085AbUJSTAj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 15:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269647AbUJSS6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 14:58:45 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:28143 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S269655AbUJSS6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 14:58:09 -0400
To: Tom Rini <trini@kernel.crashing.org>
Cc: sam@ravnborg.org, akpm@osdl.org, linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <52is979pah.fsf@topspin.com>
	<20041019164449.GF6298@smtp.west.cox.net>
	<521xfua835.fsf_-_@topspin.com>
	<20041019182928.GA12544@smtp.west.cox.net>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 19 Oct 2004 11:58:03 -0700
In-Reply-To: <20041019182928.GA12544@smtp.west.cox.net> (Tom Rini's message
 of "Tue, 19 Oct 2004 11:29:28 -0700")
Message-ID: <52wtxm8ric.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH/take 2] ppc: fix build with O=$(output_dir)
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 19 Oct 2004 18:58:04.0239 (UTC) FILETIME=[9024FDF0:01C4B60D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Tom> This misses the bit to invoke the checker as well (when I
    Tom> first thought this up I poked Al Viro about the general
    Tom> question of checker on boot code, and he wanted it, so...).
    Tom> And having 2 'magic' rules not just 1 is why I don't like
    Tom> this too much and was hoping Sam would have some idea of a
    Tom> good fix.

Hmm, good point, forgot about the checker.  I tried various magic ways
of fixing this with vpath etc. but I couldn't mke it work.  Sam,
you're our last hope I guess.

Thanks,
  Roland
