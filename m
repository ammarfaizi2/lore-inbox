Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWEOIXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWEOIXe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 04:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWEOIXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 04:23:34 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:1745 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S964805AbWEOIXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 04:23:33 -0400
Date: Mon, 15 May 2006 10:23:20 +0200
From: Sander <sander@humilis.net>
To: Michael Robak <mrobak@Omneon.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sata_mv module fails to load properly with 3 Supermicro AOC-SAT2-MV8 cards
Message-ID: <20060515082319.GB13061@favonius>
Reply-To: sander@humilis.net
References: <F0E8D0B1F8999D479196DA72521D954A87FBAB@snv-exh1.omneon.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F0E8D0B1F8999D479196DA72521D954A87FBAB@snv-exh1.omneon.local>
X-Uptime: 08:26:46 up 6 days, 23:15, 34 users,  load average: 3.71, 3.40, 3.14
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Robak wrote (ao):
> Problem:
>   sata_mv module fails to load properly with 3 Supermicro AOC-SAT2-MV8
>   cards

I've reported more or less the same to the current maintainer. The third
card fails to work properly. In my case it seems to be because the first
two PCI-X slots are 133MHz and the third is 100MHz (Tyan K8SE).

Does that fit your case?

	With kind regards, Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
