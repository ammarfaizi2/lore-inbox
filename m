Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262517AbULDAbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbULDAbu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 19:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbULDAbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 19:31:49 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:56283 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262514AbULDAaU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 19:30:20 -0500
Date: Sat, 4 Dec 2004 01:26:57 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Nicholas Papadakos <panic@quake.gr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: realtek r8169 + kernel 2.4.24 (openmosix)
Message-ID: <20041204002657.GA26399@electric-eye.fr.zoreil.com>
References: <200412032336.iB3NaiCk027949@rosebud.otenet.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412032336.iB3NaiCk027949@rosebud.otenet.gr>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Papadakos <panic@quake.gr> :
[...]
> I am trying to use a realtek r8169 gigabit Ethernet levelone card as a link
> between two machines that are cluster using openmosix, However whenever I
> try to transfer large amounts of data after 5 secs the connections freezes.
> I found a similar older post with an attacked patch to try, I tried it but
> the problem remained. Any help ?
> I don't want to upgrade kernel to something else as I need openmosix to keep
> running.

I know it's fri^Wsatursday but it does not help if you do not specify which
patch you applied.

At a minimum, you want to upgrade the sources of the r8169 driver up to a
more recent 2.4.x: simply drop a drivers/net/r8169.c from the latest 2.4.x
into your 2.4.24 tree, rebuild and report the result (+ complete dmesg +
lspci -vx + lsmod for my collection please).

Cc: netdev@oss.sgi.com is welcome.

--
Ueimor
