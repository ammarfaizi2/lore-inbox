Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbVHHLgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbVHHLgj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 07:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVHHLgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 07:36:39 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:40844 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750823AbVHHLgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 07:36:38 -0400
Date: Mon, 8 Aug 2005 15:21:53 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: New asynchronous crypto subsystem [acrypto] release.
Message-ID: <20050808112153.GA13638@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 08 Aug 2005 15:21:54 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm pleased to announce new acrypto release.
It now supports nice scatterlist walkers, usage can be found in
async_provider.c [bridge to the sync API].
By design acrypto provides whole scatterlists array to the
driver so it can optimize it's processing.

This is _probably_ the last release, due to starting asynchronous
development based on top of existing SW/TFM crypto stack,
but work is not completely stopped, it just goes into the shadow.

As usual, archive is available at
http://tservice.net.ru/~s0mbre/archive/acrypto

Acrypto page can be found at
http://tservice.net.ru/~s0mbre/?section=projects&item=acrypto

Archive contains acrypto subsystem itself, driver for HIFN 795x cards, 
driver for SuperCrypt CE99C003B chip, driver for VIA padlock engine, 
port of the existing HW RNG for AMD/Intel/VIA to acrypto,
asynchronous crypto provider based on SW stack for AES, and 
asynchronous IPsec support for in-kernel IPsec engine and it's 
binding to acrypto.

-- 
	Evgeniy Polyakov
