Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267498AbTAXCXN>; Thu, 23 Jan 2003 21:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267499AbTAXCXN>; Thu, 23 Jan 2003 21:23:13 -0500
Received: from pizda.ninka.net ([216.101.162.242]:26598 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267498AbTAXCXM>;
	Thu, 23 Jan 2003 21:23:12 -0500
Date: Thu, 23 Jan 2003 18:21:14 -0800 (PST)
Message-Id: <20030123.182114.97716922.davem@redhat.com>
To: bgoglin@ens-lyon.fr
Cc: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: AH transformation broken since 2.5.56
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030122133107.GD13948@ens-lyon.fr>
References: <20030122133107.GD13948@ens-lyon.fr>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Brice Goglin <bgoglin@ens-lyon.fr>
   Date: Wed, 22 Jan 2003 14:31:07 +0100

   Support for IPsec AH in net/ipv4/ah.c is broken since 2.5.56
   (still broken in 2.5.59).
   I tried with CONFIG_INET_AH=y and m, I got the same error :

You have to enable CONFIG_CRYPTO_HMAC if you want to enable
CONFIG_INET_AH
