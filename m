Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261670AbSJCOka>; Thu, 3 Oct 2002 10:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263266AbSJCOka>; Thu, 3 Oct 2002 10:40:30 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:61360 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261670AbSJCOk3>;
	Thu, 3 Oct 2002 10:40:29 -0400
Message-ID: <3D9C5827.70703@colorfullife.com>
Date: Thu, 03 Oct 2002 16:45:59 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.40-ac1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > o	Fix abuse of set_bit in winbond-840		(me)

Were there bug reports, Have you tested the change?

I think the cpu_to_le32 is wrong.

On big endian computers, the nic is set into a big-endian mode, and it 
did work with set_bit on my power mac. Unfortunately, I don't have 
access to it right now.

--
	Manfred




