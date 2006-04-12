Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWDLJuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWDLJuX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 05:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWDLJuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 05:50:22 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:712 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932126AbWDLJuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 05:50:22 -0400
Date: Wed, 12 Apr 2006 13:50:17 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: New asycnhronous crypto layer (acrypto) release.
Message-ID: <20060412095017.GA14530@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 12 Apr 2006 13:50:18 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Acrypto [1] - asynchronous crypto layer for linux kernel 2.6

New acrypto combined patch for 2.6.15 kernel tree has been released, which
fixes IPsec ESP4 tunnel mode processing and initialization dependency on
connector when acrypto is built statically.
Many thanks to Yakov Lerner for testing.
Patch [2] is available in archive [3].

New standalone acrypto source released. It is a sync with combined
patch, so it only includes resolution of dependency on connector when
acrypto is built statically. It is available in archive [3].

Main work is concentrated on 2.6.16 IPsec port, which was noticebly
changed after 2.6.15.

1. http://tservice.net.ru/~s0mbre/old/?section=projects&item=acrypto
2. http://tservice.net.ru/~s0mbre/archive/acrypto/drivers/acrypto-combined-2.6.15.diff.2
3. http://tservice.net.ru/~s0mbre/archive/acrypto

-- 
	Evgeniy Polyakov
