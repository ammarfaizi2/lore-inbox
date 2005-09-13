Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbVIMBKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbVIMBKW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 21:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbVIMBKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 21:10:22 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:8068 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932267AbVIMBKV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 21:10:21 -0400
Subject: Re: pm_register should die
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David McCullough <davidm@snapgear.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@osdl.org>,
       vojtech@suse.cz, dwmw2@infradead.org, netdev@vger.kernel.org,
       benjamin_kong@ali.com.tw, dagb@cs.uit.no, jgarzik@pobox.com,
       twoller@crystal.cirrus.com, alan@redhat.com, mm@caldera.de,
       scott@spiteful.org, jsimmons@transvirtual.com
In-Reply-To: <20050913000335.GA10418@beast>
References: <20050912093456.GA29205@elf.ucw.cz>
	 <20050913000335.GA10418@beast>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 13 Sep 2005 02:32:01 +0100
Message-Id: <1126575121.31228.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > be fixed. Alan is best contact I could find for ad1848... does someone
> > care about that driver, anyway? nm256_audio is written by
> > anonymous. Wonderfull...

AD1848 docs are public, NM256 was reverse engineered so no docs. Most
users are now using the ALSA layer. It might be simplest to kill
pm_register after OSS goes, which is now scheduled anyway.


