Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWAYVpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWAYVpt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 16:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWAYVpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 16:45:49 -0500
Received: from quechua.inka.de ([193.197.184.2]:58295 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932146AbWAYVps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 16:45:48 -0500
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Red zones (was: [PATCH] garbage values in file /proc/net/sockstat)
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <43D4DA15.4010009@cosmosbay.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1F1sSY-0004yP-00@calista.inka.de>
Date: Wed, 25 Jan 2006 22:45:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> wrote:
> We can use a red zone big enough to hold the whole per_cpu data.

I am trying to learn a bit here: why is it required to have a speciel red
zone for this case? Wouldnt it make more sence to have a single red zone
which can be used by all locations in the kernel for unused structures? That
would reduce the number of wasted segements in the page table, or?

Gruss
Bernd
