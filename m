Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264672AbSKIJQy>; Sat, 9 Nov 2002 04:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264673AbSKIJQy>; Sat, 9 Nov 2002 04:16:54 -0500
Received: from mta01bw.bigpond.com ([139.134.6.78]:16895 "EHLO
	mta01bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S264672AbSKIJQx> convert rfc822-to-8bit; Sat, 9 Nov 2002 04:16:53 -0500
Content-Type: text/plain; charset=US-ASCII
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Solved 2.4.20pre11aa1/2.4.20rc1aa1 Agpgart/Radeon crash. [was: Re: 2.4.20pre11aa1]
Date: Sat, 9 Nov 2002 20:34:39 +1100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20021018145204.GG23930@dualathlon.random> <200210260003.06285.harisri@bigpond.com> <200210312147.42836.harisri@bigpond.com>
In-Reply-To: <200210312147.42836.harisri@bigpond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211092034.39100.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

> So I believe either 1* or 2* patches are introducing the issue.

Got it. The 10_x86-fast-pte2 patch is introducting the instability.

I have tested it on 2.4.20rc1aa1 though, backing out that patch alone solves 
the instability.

I can give the .config and ksymoops of 2.4.20rc1aa1 if needed.

> In the mean time I had an opportunity to test -aa on a nice IBM NetVista
> computer, whose configuration is as follows:

I will verify this finding even on that computer perhaps on Monday.

Thanks for your help.
-- 
Hari
harisri@bigpond.com

