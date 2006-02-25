Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbWBYNsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWBYNsZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 08:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWBYNsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 08:48:24 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:24032 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1030248AbWBYNsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 08:48:24 -0500
Date: Sat, 25 Feb 2006 22:48:15 +0900 (JST)
Message-Id: <20060225.224815.93020442.anemo@mba.ocn.ne.jp>
To: yoichi_yuasa@tripeaks.co.jp
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org
Subject: Re: [-mm PATCH] mips: fixed collision of rtc function name
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060225012721.52c4827b.yoichi_yuasa@tripeaks.co.jp>
References: <20060224031002.0f7ff92a.akpm@osdl.org>
	<20060225012721.52c4827b.yoichi_yuasa@tripeaks.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 25 Feb 2006 01:27:21 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> said:

yoichi> This patch has fixed the collision of rtc function name on
yoichi> 2.6.16-rc4-mm2.

You missed changes for include/asm-mips/rtc.h (an interface for genrtc
driver) ?  Or genrtc driver will be gone in the new RTC subsystem?

---
Atsushi Nemoto
