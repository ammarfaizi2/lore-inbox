Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266495AbUGUK7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266495AbUGUK7g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 06:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266492AbUGUK7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 06:59:33 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:45253 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S266491AbUGUK7a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 06:59:30 -0400
Date: Wed, 21 Jul 2004 12:56:22 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: r8169 in 2.6.7: transfer stops after few seconds
Message-ID: <20040721125622.A31273@electric-eye.fr.zoreil.com>
Mail-Followup-To: Francois Romieu <romieu@fr.zoreil.com>,
	"Vladimir B. Savkin" <master@sectorb.msk.ru>,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <20040721083406.GA5785@usr.lcm.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040721083406.GA5785@usr.lcm.msu.ru>; from master@sectorb.msk.ru on Wed, Jul 21, 2004 at 12:34:06PM +0400
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir B. Savkin <master@sectorb.msk.ru> :
> My realtek-8169 based NIC doesn't work with 2.6.
> Kernel versions tried: 2.6.7, 2.6.7-mm7.
> Works OK with 2.4.26.
[...]
> Is there any other info I can supply you with to debug this problem?

- dmesg once the card is up/stopped (please provide complete dmesg from
  boot as it usually gets truncated and misses the compiler info)
- ifconfig output once the card is stopped
- lspci -vx

Did you try 2.6.6 or previous kernel in the 2.6.x serie ?

Please redirect traffic to netdev@oss.sgi.com.

--
Ueimor
