Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbVJSLXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVJSLXm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 07:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVJSLXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 07:23:41 -0400
Received: from mail.linicks.net ([217.204.244.146]:61970 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1750758AbVJSLXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 07:23:41 -0400
From: Nick Warne <nick@linicks.net>
To: Karel Kulhavy <clock@twibright.com>
Subject: Re: 3c900 boot-time kernel commandline parameters in 2.4.25
Date: Wed, 19 Oct 2005 12:23:31 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510191223.31751.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How do I tell Linux kernel 2.4.25 on boot-time kernel commandline to
> switch my eth0
> ~
> to TP transceiver and 10/100 autonegotiation?

Not really a kernel question.  Do a 'man mii-tool' or 'man ethtool'.

Either of those allow NIC tweaking.

I run ethtool to force 100MB FD in rc.local - you can do similar depending on 
your style/distro.

Nick
-- 
http://sourceforge.net/projects/quake2plus

"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb

