Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265222AbUETVap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbUETVap (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 17:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265278AbUETVap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 17:30:45 -0400
Received: from main.gmane.org ([80.91.224.249]:13485 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265222AbUETVao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 17:30:44 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jonas Wolz <jonas.wolz@freenet.de>
Subject: Re: Sluggish performances with FreeBSD
Date: Thu, 20 May 2004 23:22:47 +0200
Message-ID: <c8j7ja$3u6$1@sea.gmane.org>
References: <1085080302.7764.20.camel@caribou.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p5083c443.dip0.t-ipconnect.de
User-Agent: KNode/0.7.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Goujon wrote:
> [laptop with sis900 NIC]
> My problem is :
> I have very poor performances with tcp streams from my server to my
> laptop (0.35 Mb/s), but throughput is normal from the laptop to the
> server (90Mb/s) and also (my favorite one) from Internet to my laptop
> (~4Mb/s).
> When I'm running WinXP, all is quite normal.

You're obviously not the only one with that problem, because I'm having a
similar problem with my laptop's (Acer Aspire 1705SCi) sis900 NIC:

If I test network performance using netio I get ~4.4 MByte/s from my Linux
server (RTL8139 NIC) to the laptop but ~11 MB/s from the laptop to the
server (if the laptop is running Linux).
Disabling ACPI or the APIC doesn't help in my case, too.

When I'm running WinXP or FreeBSD on the laptop I get 11 MB/s in both
directions.


Jonas Wolz

