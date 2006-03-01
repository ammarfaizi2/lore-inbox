Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751567AbWCAE0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbWCAE0a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 23:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbWCAE0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 23:26:30 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:13977 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S1751520AbWCAE03
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 23:26:29 -0500
Date: Wed, 1 Mar 2006 14:26:32 +1000
From: David McCullough <david_mccullough@au.securecomputing.com>
To: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ocf-linux-20060301 - Asynchronous Crypto support for linux
Message-ID: <20060301042632.GA17290@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

A new release of the ocf-linux package is up:

	http://ocf-linux.sourceforge.net/

Mostly Openswan updates/cleanups and fixes in this release.

* Well tested on 2.4.32 and 2.6.15 with OpenSwan.
* hold locks for less time which improves
  the cryptosoft (software driver) interaction
  with the system.
* fix cryptodev to handle CRIOGET requests when
  application is chrooted.
* Bug fixes and improvements by Ronen Shitrit
  md5/sha processing in cryptosoft
  other typo/ordering problems in cryptosoft
  more error reporting to make debugging easier.
* updated openswan patch for 2.4.5rc5
* openswan support no longer requires any other crypto
  code (other than OCF) to be configured in.
* openswan code Q's state machine when in interrupt context
  and calls immediately when not (previously compile time
  determined)
* openssh uses OCF appropriately now if it supports required   
  algs
* updated ssl patch to openssl-0.9.8a
* no patch required for openssh anymore
* openssl md5/sha support by Ronen Shitrit

Cheers,
Davidm

-- 
David McCullough, david_mccullough@au.securecomputing.com, Ph:+61 734352815
Secure Computing - SnapGear  http://www.uCdot.org http://www.cyberguard.com
