Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132752AbRDDGue>; Wed, 4 Apr 2001 02:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132753AbRDDGuY>; Wed, 4 Apr 2001 02:50:24 -0400
Received: from [202.54.26.202] ([202.54.26.202]:28319 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S132752AbRDDGuK>;
	Wed, 4 Apr 2001 02:50:10 -0400
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: linux-kernel@vger.kernel.org
Message-ID: <65256A24.00233ECF.00@sandesh.hss.hns.com>
Date: Wed, 4 Apr 2001 12:00:58 +0530
Subject: get_pid() : enahancement
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



In 2.4 kernel we now have no limit on the number of tasks running on a system
(no NR_TASKS anymore)...

I was just wondering on the efficiency of get_pid() implemetation... Although
'next_safe' concept in this function seems useful but I think we now need a
robust PID allocator..

We can have a discussion so that get_pid() can be made more effecient in future
kernel.

Amol


