Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265061AbUAAWWf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 17:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264594AbUAAWWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 17:22:35 -0500
Received: from h24-77-129-12.wp.shawcable.net ([24.77.129.12]:26854 "EHLO ubb")
	by vger.kernel.org with ESMTP id S265061AbUAAWUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 17:20:07 -0500
From: "Tony 'Nicoya' Mantler" <nicoya@ubb.ca>
To: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 357] Mac89x0 Ethernet
References: <19hM1-19q-19@gated-at.bofh.it> <19iRU-2Hc-43@gated-at.bofh.it>
Organization: Judean People's Front; Department of Whips, Chains, Thumb-Screws, Six Tons of Whipping Cream, the Entire Soprano Section of the Mormon Tabernacle Choir and Guest Apperances of Eva Peron aka Eric Conspiracy Secret Laboratories
X-Disclaimer-1: This message has been edited from it's original form by members of the Eric Conspiracy.
X-Disclaimer-2: There is no Eric Conspiracy.
User-Agent: MT-NewsWatcher/3.3b1 (PPC Mac OS X)
Date: Thu, 01 Jan 2004 16:19:49 -0600
Message-ID: <nicoya-BAEF3D.16194901012004@news.sc.shawcable.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <19iRU-2Hc-43@gated-at.bofh.it>, Jeff Garzik <jgarzik@pobox.com> 
wrote:

: > +	/* Write the contents of the packet */
: > +	memcpy((void *)(dev->mem_start + PP_TxFrame), skb->data, skb->len+1);
: 
: Is dev->mem_start DMA memory?

Old macs (with a few oddball exceptions) don't do DMA. dev->mem_start points to 
the start of the card's NuBus-ish space, which the frame is being copied into in 
this case.


Cheers - Tony 'Nicoya' Mantler :)

-- 
Tony 'Nicoya' Mantler -- Master of Code-fu -- nicoya@ubb.ca
--  http://nicoya.feline.pp.se/  --  http://www.ubb.ca/  --
