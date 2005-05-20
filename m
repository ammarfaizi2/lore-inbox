Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVETOBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVETOBX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 10:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVETOBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 10:01:00 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:8324 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S261466AbVETN50
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 09:57:26 -0400
Date: Fri, 20 May 2005 23:57:23 +1000
From: David McCullough <davidm@snapgear.com>
To: linux-crypto@vger.kernel.org
Cc: cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org
Subject: ocf-linux-20050520 - Asynchronous Crypto support for linux
Message-ID: <20050520135723.GB26883@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

A new release of the ocf-linux package is up:

	http://ocf-linux.sourceforge.net/

A lot of changes in this release.  Best to check the Changelog below
for the specifics.  Most of the changes have centered around RNG, PKE
or getting Openswan running with OCF.

No 2.6 testing was done for this release,  but it should be close
if it doesn't work.

The OpenSwan 2.3.0 patch of accelerates receive packets only
at this point.  This is just to get the basics out there for comment
while the transmit side is coded.

Changes:
* Mostly complete SKB processing for all drivers
* Numerous fixes to all drivers (esp. cryptosoft)
* All drivers can now do ESP/AH processing on buffers, skb's
  or iovecs.
* Re-work of the ixp4xx driver (multiple  outstanding requests)
* PKE support working in safenet
* New demand driven RNG support with optional FIPS140 testing of data
* Openswan RX-only support for comment
* Fixed race condition in ocf driver startup

Cheers,
Davidm

-- 
David McCullough, davidm@snapgear.com  Ph:+61 7 34352815 http://www.SnapGear.com
Custom Embedded Solutions + Security   Fx:+61 7 38913630 http://www.uCdot.org
