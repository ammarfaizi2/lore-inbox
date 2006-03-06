Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWCFVMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWCFVMk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWCFVMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:12:39 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:17043 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S932259AbWCFVMj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:12:39 -0500
Date: Mon, 6 Mar 2006 21:12:30 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm PATCH] mips: fixed collision of rtc function name
Message-ID: <20060306211230.GC27612@linux-mips.org>
References: <20060224031002.0f7ff92a.akpm@osdl.org> <20060225012721.52c4827b.yoichi_yuasa@tripeaks.co.jp> <20060225.224815.93020442.anemo@mba.ocn.ne.jp> <20060227074304.56dbecac.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227074304.56dbecac.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 07:43:04AM +0900, Yoichi Yuasa wrote:

> > yoichi> This patch has fixed the collision of rtc function name on
> > yoichi> 2.6.16-rc4-mm2.
> > 
> > You missed changes for include/asm-mips/rtc.h (an interface for genrtc
> > driver) ?  Or genrtc driver will be gone in the new RTC subsystem?
> 
> The new RTC subsystem don't have genrtc driver.
> I think we should move from genrtc driver to the new RTC subsystem.

Definately preferable.  I took the RTC subsystem patches as the reason
to do some more cleaning in the MIPS RTC code.  It's all quite disgusting
but untangeling it is something one can easily burn a day or more on ...

   Ralf
