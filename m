Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131628AbRAEBdp>; Thu, 4 Jan 2001 20:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131633AbRAEBdf>; Thu, 4 Jan 2001 20:33:35 -0500
Received: from open.your.mind.be ([195.162.205.66]:37370 "HELO
	portablue.intern.mind.be") by vger.kernel.org with SMTP
	id <S131628AbRAEBdU>; Thu, 4 Jan 2001 20:33:20 -0500
Date: Fri, 5 Jan 2001 02:32:35 +0100
To: linux-kernel@vger.kernel.org
Subject: compile problem in prerelease-ac6 on alpha
Message-ID: <20010105023235.A784@mind.be>
Mail-Followup-To: p2@mind.be, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Answer: 42
X-Operating-system: Debian GNU/Linux
From: p2@mind.be (Peter De Schrijver)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At line 1156 of kernel/sched.c a function is called which only seems to exist
on ia32 (show_trace). I guess this should be :

#if __i386__
	show_trace(p->thread.esp):
#endif

Cheers,

Peter.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
