Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWHPWrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWHPWrt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 18:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWHPWrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 18:47:49 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:30195 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932308AbWHPWrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 18:47:47 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
Date: Thu, 17 Aug 2006 00:47:00 +0200
User-Agent: KMail/1.9.1
Cc: David Miller <davem@davemloft.net>, akpm@osdl.org, jeff@garzik.org,
       netdev@vger.kernel.org, jklewis@us.ibm.com,
       linux-kernel@vger.kernel.org, Jens.Osterkamp@de.ibm.com
References: <200608162324.47235.arnd@arndb.de> <200608170016.47072.arnd@arndb.de> <20060816.152919.88472383.davem@davemloft.net>
In-Reply-To: <20060816.152919.88472383.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608170047.00811.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thursday 17 August 2006 00:29 schrieb David Miller:
> Didn't you say spidernet's facilities were sophisticated? :)
> This Tigon3 stuff is like 5+ year old technology.

I was rather overwhelmed by the 34 different interrupts that
the chip can create, that does not mean they chose the right
events for generating them.
Interestingly, spidernet has five different counters you can
set up to generate interrupts after a number of received frames,
but none for transmit...

	Arnd <><
