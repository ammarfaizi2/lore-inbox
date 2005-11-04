Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbVKDPj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbVKDPj1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbVKDPj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:39:27 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:46296 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751504AbVKDPj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:39:26 -0500
Date: Fri, 4 Nov 2005 16:39:20 +0100 (CET)
From: Peter Osterlund <petero2@telia.com>
X-X-Sender: petero@p4.localdomain
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org, ace@staticwave.ca
Subject: Re: [2.6 patch] drivers/block/pktcdvd.c: remove write-only variable
 in pkt_iosched_process_queue()
In-Reply-To: <20051102091059.GF8009@stusta.de>
Message-ID: <Pine.LNX.4.58.0511041638240.17790@telia.com>
References: <20051102091059.GF8009@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, Adrian Bunk wrote:

> Found this on Coverty's linux bug database (http://linuxbugsdb.coverity.com).
>
> The function pkt_iosched_process_queue makes a call to bdev_get_queue
> and stores the result but never uses it, so it looks like it can be
> safely removed.
>
> From: Gabriel A. Devenyi <ace@staticwave.ca>

Thanks. The patch looks good.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
