Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWBZWnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWBZWnQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 17:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWBZWnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 17:43:16 -0500
Received: from mo00.po.2iij.Net ([210.130.202.204]:3309 "EHLO mo00.po.2iij.net")
	by vger.kernel.org with ESMTP id S1751191AbWBZWnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 17:43:15 -0500
Date: Mon, 27 Feb 2006 07:43:04 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: yoichi_yuasa@tripeaks.co.jp, akpm@osdl.org, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org
Subject: Re: [-mm PATCH] mips: fixed collision of rtc function name
Message-Id: <20060227074304.56dbecac.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060225.224815.93020442.anemo@mba.ocn.ne.jp>
References: <20060224031002.0f7ff92a.akpm@osdl.org>
	<20060225012721.52c4827b.yoichi_yuasa@tripeaks.co.jp>
	<20060225.224815.93020442.anemo@mba.ocn.ne.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2006 22:48:15 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> >>>>> On Sat, 25 Feb 2006 01:27:21 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> said:
> 
> yoichi> This patch has fixed the collision of rtc function name on
> yoichi> 2.6.16-rc4-mm2.
> 
> You missed changes for include/asm-mips/rtc.h (an interface for genrtc
> driver) ?  Or genrtc driver will be gone in the new RTC subsystem?

The new RTC subsystem don't have genrtc driver.
I think we should move from genrtc driver to the new RTC subsystem.

Yoichi
