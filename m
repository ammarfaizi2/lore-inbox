Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282449AbRKZTso>; Mon, 26 Nov 2001 14:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282447AbRKZTr0>; Mon, 26 Nov 2001 14:47:26 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:6340 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S282445AbRKZTq3>;
	Mon, 26 Nov 2001 14:46:29 -0500
Date: Mon, 26 Nov 2001 11:46:10 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Scheduler Cleanup
Message-ID: <20011126114610.B1141@w-mikek2.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm happy to see the cleanup of scheduler code that went into
2.4.15/16.  One small difference in behavior (I think) is that
the currently running task is not given preference over other
tasks on the runqueue with the same 'goodness' value.  I would
think giving the current task preference is a good thing
(especially in light of recent discussions about too frequent
moving/rescheduling of tasks).  Can someone provide the rational
for this change?  Was it just the result of making the code
cleaner?  Is it believed that this won't really make a difference?

-- 
Mike
