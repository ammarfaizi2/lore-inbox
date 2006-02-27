Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWB0TvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWB0TvP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWB0TvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:51:15 -0500
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:1719 "EHLO
	smtpq2.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S932077AbWB0TvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:51:14 -0500
Message-ID: <4403586C.2020004@keyaccess.nl>
Date: Mon, 27 Feb 2006 20:52:12 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Adam Belay <ambx1@neo.rr.com>
Subject: Re: Linux v2.6.16-rc5
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Have I missed anything? Holler. And please keep reminding about any 
> regressions since 2.6.15.

This one isn't in: http://lkml.org/lkml/2006/2/21/7

Andrew did pick it up -- pnp-bus-type-fix.patch, named as being in the 
2.6.16 queue in his 2.6.16-rc4-mm2 announce:

http://lkml.org/lkml/2006/2/24/66

so it's probably okay. The other two patches from that same thread 
already made it into -rc5 though, so thought I'd ping anyway. It does 
really want to make 2.6.16. Many ISA-PnP drivers are quite severely 
broken without (it's also a regression against 2.6.15).

Rene.

