Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751690AbWJTGJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbWJTGJe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 02:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbWJTGJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 02:09:34 -0400
Received: from mailer.campus.mipt.ru ([194.85.82.4]:39404 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S1751689AbWJTGJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 02:09:33 -0400
Date: Fri, 20 Oct 2006 10:10:33 +0400
Message-Id: <200610200610.k9K6AXgP031789@vass.7ka.mipt.ru>
From: Vasily Tarasov <vtaras@openvz.org>
To: Christoph Hellwig <hch@infradead.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
CC: Jan Kara <jack@suse.cz>
CC: Dmitry Mishin <dim@openvz.org>
CC: Vasily Averin <vvs@sw.ru>
CC: Kirill Korotaev <dev@openvz.org>
CC: OpenVZ Developers List <devel@openvz.org>
References: <200610191232.k9JCW7CF015486@vass.7ka.mipt.ru> <20061019172948.GA30975@infradead.org>
Subject: Re: [PATCH] diskquota: 32bit quota tools on 64bit architectures
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Fri, 20 Oct 2006 10:09:00 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

<snip>
> Please allocate the structure using compat_alloc_userspace and copy
> with copy_in_user instead of the set_fs trick.
<snip>

Good idea, thank you for your tip, I'll do it.
