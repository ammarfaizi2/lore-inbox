Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVDNVIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVDNVIA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 17:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVDNVH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 17:07:59 -0400
Received: from unused.mind.net ([69.9.134.98]:18060 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S261597AbVDNVHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 17:07:48 -0400
Date: Thu, 14 Apr 2005 14:06:47 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: BUGs in 2.6.12-rc2-RT-V0.7.45-01
In-Reply-To: <20050412230921.GA22360@elte.hu>
Message-ID: <Pine.LNX.4.58.0504141352490.14125@echo.lysdexia.org>
References: <Pine.LNX.4.58.0504121443310.3023@echo.lysdexia.org>
 <20050412230921.GA22360@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2005, Ingo Molnar wrote:

> what are you using kprobes for? Do you get lockups even if you disable 
> kprobes?

Various processes will lockup on the P4/HT system, usually while under
some load.  The processes cannot be killed.  X will lockup once or twice a
day (which means my console, and thus sysrq, are toast), but I can still
ssh in.  Nothing is logged by the kernel.  Are there any post-lockup 
forensics that can be performed before I reboot?

Regards,
--William Weston

--
/* William Weston <weston@sysex.net> */
