Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264645AbUDVUBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264645AbUDVUBk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 16:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264652AbUDVTub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 15:50:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:4559 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264649AbUDVTuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 15:50:11 -0400
Date: Tue, 20 Apr 2004 21:26:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nick Popoff <cryptic-lkml@bloodletting.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Testing Dual Ethernet via Loopback
Message-ID: <20040420192637.GD1413@openzaurus.ucw.cz>
References: <200404190614.21764.cryptic-lkml@bloodletting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404190614.21764.cryptic-lkml@bloodletting.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> So what I'm wondering is if there is a way to force Linux to actually
> utilize its network hardware in sending these packets to itself?  In other
> words, a ping or file transfer from an IP assigned to eth0 to another IP
> assigned to eth1 should fail if I unplug the network cable connecting the
> two.  Any advice on this would be much appreciated.  I'm not afraid of
> reading kernel source but have no idea where to start on this one.

tcpdump on eth0, ping non-existant IP on eth1?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

