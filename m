Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWAIQQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWAIQQD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWAIQQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:16:01 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:28810 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964792AbWAIQP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:15:59 -0500
Date: Mon, 9 Jan 2006 17:15:55 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: gcoady@gmail.com, vherva@vianova.fi, linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
In-Reply-To: <20060108174505.6c9b7566.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.61.0601091714330.26210@yvahk01.tjqt.qr>
References: <20060105045212.GA15789@redhat.com> <Pine.LNX.4.61.0601050907510.10161@yvahk01.tjqt.qr>
 <20060105103339.GG20809@redhat.com> <20060108133822.GD31624@vianova.fi>
 <20060108055322.18d4236e.rdunlap@xenotime.net> <6cq2s1d3glnj56pcrqlj84s8ltilmo6jfp@4ax.com>
 <20060108174505.6c9b7566.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> So would it be viable to take over the screen in similar fashion?
>> 
>> Set it to 80x50 in BIOS and dump there --> call it the Penguin Oops 
>> screen, or Poops for short :o)
>
>It does take over the screen.  80x50 isn't needed since it knows how
>to scroll the kernel log buffer on 80x25.

It's needed because scrolling back might be impossible (shift-up in panic 
= no-go), not because it knows how to scroll.


Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
