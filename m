Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136800AbREKOqH>; Fri, 11 May 2001 10:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136929AbREKOps>; Fri, 11 May 2001 10:45:48 -0400
Received: from mgw-x4.nokia.com ([131.228.20.27]:36747 "EHLO mgw-x4.nokia.com")
	by vger.kernel.org with ESMTP id <S136800AbREKOpd>;
	Fri, 11 May 2001 10:45:33 -0400
Date: Fri, 11 May 2001 17:39:40 +0300
To: linux-kernel@vger.kernel.org
Subject: Question about ipip implementation
Message-ID: <20010511173940.A418@Hews1193nrc>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
From: alexey.vyskubov@nokia.com (Alexey Vyskubov)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I read net/ipv4/ipip.c. It seems to me that ipip_rcv() function after
"unwrapping" tunelled IP packet creates "virtual Ethernet header" and submit
corresponding sk_buff to netif_rx().

Is there a some reason to do things this way instead of calling ip_rcv() for
"unwrapped" IP packet?

-- 
Alexey
