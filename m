Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267621AbRGZFpM>; Thu, 26 Jul 2001 01:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267624AbRGZFox>; Thu, 26 Jul 2001 01:44:53 -0400
Received: from [200.222.195.52] ([200.222.195.52]:12716 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S267621AbRGZFov>; Thu, 26 Jul 2001 01:44:51 -0400
Date: Thu, 26 Jul 2001 02:44:50 -0300
From: =?iso-8859-1?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <0@pervalidus.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Unresolved symbols in 2.4.7 ppp_generic.o ?
Message-ID: <20010726024450.T11246@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.19i
X-Mailer: Mutt/1.3.19i - Linux 2.4.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi. I just built 2.4.7 (I patched 2.4.6 to 2.4.7) and doing a
depmod noticed the following:

depmod: *** Unresolved symbols in /lib/modules/2.4.7/kernel/drivers/net/ppp_generic.o
depmod:    slhc_init
depmod:        slhc_free
depmod:        slhc_uncompress
depmod:  slhc_toss
depmod:        slhc_remember
depmod:    slhc_compress

I don't know what's wrong because I first did a make mrproper.

Maybe something was missing from patch-2.4.7.bz2 ?

-- 
0@pervalidus.{net, {dyndns.}org} Tel: 55-21-2717-2399 (Niterói-RJ BR)
