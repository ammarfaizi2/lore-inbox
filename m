Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265322AbUFOGqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265322AbUFOGqL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 02:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbUFOGqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 02:46:11 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:43528 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S265322AbUFOGqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 02:46:10 -0400
From: Meelis Roos <mroos@linux.ee>
To: bikram.assal@wku.edu, linux-kernel@vger.kernel.org
Subject: Re: eepro100 NIC driver. any bug ?
In-Reply-To: <web-68980662@mailadmin.wku.edu>
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.7-rc3 (i686))
Message-Id: <E1Ba7hC-0001uK-Bl@rhn.tartu-labor>
Date: Tue, 15 Jun 2004 09:45:22 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BA> Would you suggest ee100 over eepro100 driver for an INTEL NIC ?
BA> 
BA> kernel: NETDEV WATCHDOG: eth1: transmit timed out
BA> Jun 2 12:56:24 kernel: eth1: Transmit timed out: status f048 0c00 at 1703794288/1703794348 command 200ca000.

A co-worker had a very similar problem with eepro100 when I switched his
computer from 100 Mbps fullduplex switch to 10Mbps halfduplex hub. The
problems went away with e100 driver. It was with a revent kernel about a
month ago but I don't remeber whether it was a recent 2.4 or a recent
2.6 kernel. The NIC in question is the onboard NIC of Intel D815EEA2
mainboard.

-- 
Meelis Roos
