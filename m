Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbUDMQde (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 12:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263502AbUDMQde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 12:33:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17079 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263484AbUDMQdc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 12:33:32 -0400
Message-ID: <407C164F.1090501@pobox.com>
Date: Tue, 13 Apr 2004 12:33:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 437] Amiga eth%d
References: <200404130838.i3D8cI26018497@callisto.of.borg>
In-Reply-To: <200404130838.i3D8cI26018497@callisto.of.borg>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> Amiga Ethernet drivers: Print card info after calling register_netdev(), to
> avoid dev->name still being 'eth%d'.


ACK.

As a further change, can you please add KERN_xxx prefixes to those printk's?

	Jeff



