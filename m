Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVBJUVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVBJUVb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 15:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVBJUVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 15:21:31 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:10993 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261698AbVBJUVY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 15:21:24 -0500
Message-ID: <420BC23F.6030308@mvista.com>
Date: Thu, 10 Feb 2005 12:21:19 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: William Weston <weston@lysdexia.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
References: <20050204100347.GA13186@elte.hu> <Pine.LNX.4.58.0502081135340.21618@echo.lysdexia.org> <20050209115121.GA13608@elte.hu> <Pine.LNX.4.58.0502091233360.4599@echo.lysdexia.org> <20050210075234.GC9436@elte.hu>
In-Reply-To: <20050210075234.GC9436@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I want to write a patch that will work with or without the RT patch applied 
is the following enough?

#ifndef RAW_SPIN_LOCK_UNLOCKED
typedef raw_spinlock_t spinlock_t
#define RAW_SPIN_LOCK_UNLOCKED SPIN_LOCK_UNLOCKED
#endif


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

