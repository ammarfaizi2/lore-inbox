Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276911AbRJCI0M>; Wed, 3 Oct 2001 04:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276914AbRJCI0B>; Wed, 3 Oct 2001 04:26:01 -0400
Received: from csa.iisc.ernet.in ([144.16.67.8]:63239 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S276911AbRJCIZo>;
	Wed, 3 Oct 2001 04:25:44 -0400
Date: Wed, 3 Oct 2001 13:55:32 +0530 (IST)
From: "M.Gopi Krishna" <mgopi@csa.iisc.ernet.in>
To: linux-kernel@vger.kernel.org
Subject: wait_event() :(
Message-ID: <Pine.LNX.4.21.0110031351580.21283-100000@opal.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a doubt regarding wait_event.
In the macro __wait_event, the calling process changes its state to
TASK_UNINTERRUPTIBLE and calls schedule.
And does this in infinite loop.
After the loop, it itself changes its state to TASK_RUNNING.

Once it calls schedule(), the scheduler will remove it from task list as
it is in uninterruptible mode.
Then when does it come again into running state to check the condition.

kindly cc the reply to me as i'm not subscribed to the list
thanks

-- 
gopi.

