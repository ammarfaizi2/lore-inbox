Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272012AbTGYLEY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 07:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272013AbTGYLEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 07:04:24 -0400
Received: from mail2.bluewin.ch ([195.186.4.73]:48834 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id S272012AbTGYLEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 07:04:20 -0400
Date: Fri, 25 Jul 2003 13:19:26 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE DMA disabled messages for wrong drive?
Message-ID: <20030725111926.GA3793@k3.hellgate.ch>
Mail-Followup-To: Meelis Roos <mroos@linux.ee>,
	linux-kernel@vger.kernel.org
References: <Pine.GSO.4.44.0307242031310.7781-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0307242031310.7781-100000@math.ut.ee>
X-Operating-System: Linux 2.4.21 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jul 2003 20:36:14 +0300, Meelis Roos wrote:
> I access hdd, I get DMA timeouts for hdd (for whatever reasons), then
> suddenly comes a message that DMA is disabled for hdc (not hdd).  hdc
> was not accessed at all suring this time - it's a cdrom and no CD was
> inserted and no CD access was tried.

I have seen this, too, with two harddisks (hda, hdb) on a recent 2.5
kernel: warnings about DMA timeouts on one of them, immediately followed by
a message about turning off DMA on the other one. I had to replace one of
the disks subsequently and lost the logs, but I remember wondering about
that. I supposed the kernel might have some reason to blame the hard disk
without warnings (both harddisks seemed rather suspicious at the time).

Roger
