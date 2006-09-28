Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751867AbWI1MI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbWI1MI3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 08:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965406AbWI1MI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 08:08:29 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:27089 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751867AbWI1MI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 08:08:27 -0400
Date: Thu, 28 Sep 2006 16:08:26 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, netdev@vger.kernel.org
Subject: [ACRYPTO] New asynchronous crypto layer (acrypto) release.
Message-ID: <20060928120826.GA18063@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 28 Sep 2006 16:08:27 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I'm pleased to announce asynchronous crypto layer (acrypto) [1] release 
for 2.6.18 kernel tree. Acrypto allows to handle crypto requests 
asynchronously in hardware.

Combined patchset includes:
 * acrypto core
 * IPsec ESP4 port to acrypto
 * dm-crypt port to acrypto
 * OCF to acrypto bridge

Acrypto supports following crypto providers:
 * SW crypto provider
 * HIFN 795x adapters
 * VIA nehemiah CPU
 * SuperCrypt CE99C003B
 * devices supported by OCF

With this release of combined patchset for 2.6.18 I drop feature
extensions for 2.6.16 and 2.6.17 trees and move them into maintenance
state.

Combined patchset [190k] and drivers for various acrypto providers can 
be found on project's homepage.

1. Acrypto homepage.
http://tservice.net.ru/~s0mbre/old/?section=projects&item=acrypto

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

-- 
	Evgeniy Polyakov


-- 
	Evgeniy Polyakov
