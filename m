Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWHAVlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWHAVlR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 17:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWHAVlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 17:41:17 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34285 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750888AbWHAVlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 17:41:16 -0400
Subject: Re: tickle NMI watchdog on serial output.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060801182529.GJ22240@redhat.com>
References: <20060801182529.GJ22240@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Aug 2006 23:00:23 +0100
Message-Id: <1154469623.15540.78.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-01 am 14:25 -0400, ysgrifennodd Dave Jones:
> Serial is _slow_ sometimes. So slow, that the NMI watchdog kicks in.

Acked-by: Alan Cox <alan@redhat.com>

To be honest however the tmout%1000 bit is just a delay loop waiting for
the chip in console synchronous printk so the whole 1000 times check is
overkill 8)

