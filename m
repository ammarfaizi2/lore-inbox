Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265510AbUGDLQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265510AbUGDLQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 07:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265509AbUGDLQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 07:16:26 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:27571 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S265510AbUGDLQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 07:16:25 -0400
Date: Sun, 4 Jul 2004 13:16:23 +0200
From: bert hubert <ahu@ds9a.nl>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Zinx Verituse <zinx@epicsol.org>, linux-kernel@vger.kernel.org
Subject: Re: 8139too in 2.6.x tx timeout
Message-ID: <20040704111623.GA12255@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Zinx Verituse <zinx@epicsol.org>, linux-kernel@vger.kernel.org
References: <20040626222304.GA31195@bliss> <87hdsoghdv.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87hdsoghdv.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2004 at 08:07:40PM +0900, OGAWA Hirofumi wrote:

> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: Transmit timeout, status 0d 0000 c07f media 08.
> eth0: Tx queue start entry 25  dirty entry 21.
> eth0:  Tx descriptor 0 is 10080062.
> eth0:  Tx descriptor 1 is 00080062. (queue head)
> eth0:  Tx descriptor 2 is 00080062.
> eth0:  Tx descriptor 3 is 00080062.
> eth0: link up, 10Mbps, half-duplex, lpa 0x0000
> rtl8139_hw_start: init buffer addresses

I've solved this exact problem in the bios by changing interrupts from level
to edge, or the other way around, unsure.

Earlier 2.6 did not have problems with that bios setting.


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
