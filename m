Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269325AbTCDIZx>; Tue, 4 Mar 2003 03:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269328AbTCDIZx>; Tue, 4 Mar 2003 03:25:53 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:54147 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S269325AbTCDIZw>;
	Tue, 4 Mar 2003 03:25:52 -0500
From: prash_t@softhome.net
To: linux-kernel@vger.kernel.org
Subject: Inconsistency in changing the state of task ??
Date: Tue, 04 Mar 2003 01:36:20 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [32.97.110.72]
Message-ID: <courier.3E646584.000059D3@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
     while browsing through fs/select.c file of 2.4.19, I came across two 
DIFFERENT ways of changing the state of the current task in do_select(): 

            set_current_state = TASK_INTERRUPTIBLE;
     AND    current->state = TASK_RUNNING; 

I am curious to know if the second line of code doesn't cause any problem in 
SMP systems.  I also see the same situation in do_poll(). 

Please cc to my id since I am not subscribed to the mailing list. 

Thanks
Prashanth
