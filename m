Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265689AbUGDNvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265689AbUGDNvG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 09:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265690AbUGDNvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 09:51:06 -0400
Received: from mailfe05.swip.net ([212.247.154.129]:26858 "EHLO
	mailfe05.swip.net") by vger.kernel.org with ESMTP id S265689AbUGDNvE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 09:51:04 -0400
X-T2-Posting-ID: mzHRUpvOlCbvaGn327Befg==
Date: Sun, 4 Jul 2004 15:37:15 +0200
From: Erik Rigtorp <erik@rigtorp.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/power/swsusp.c
Message-ID: <20040704133715.GA4717@linux.nu>
References: <20040703172843.GA7274@linux.nu> <20040703204647.GE31892@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040703204647.GE31892@elf.ucw.cz>
X-GPG-Key: Search for erkki@linux.nu at wwwkeys.eu.pgp.net
X-GPG-Fingerprint: 0534 CF05 8171 3EC6 921A  346F 1882 91C4 993F C709
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2004 at 10:46:47PM +0200, Pavel Machek wrote:
> You are moving it inside function that should have no business doing
> this... Would something like this work better? [hand-edited, apply by
> hand; untested].

Your patch works fine but now the swsusp resume messages appears on the
normal console instead. The swsusp console should be allocated earlier as my
patch did.
