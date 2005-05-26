Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVEZQQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVEZQQz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 12:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVEZQQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 12:16:55 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:16376 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261595AbVEZQQv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 12:16:51 -0400
Message-ID: <4295F649.7040405@mvista.com>
Date: Thu, 26 May 2005 09:16:09 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@osdl.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH rc4-mm2 2/2] posix-timers: use try_to_del_timer_sync()
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With respect to this patch:

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0505.2/1537.html

I have looked at various ways of doing this and have concluded that this is the 
right patch.
Oleg, could you resend?

Thanks
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
