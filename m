Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUCEQxa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 11:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbUCEQxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 11:53:30 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:265 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262648AbUCEQx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 11:53:26 -0500
Message-ID: <4048B36E.8000605@techsource.com>
Date: Fri, 05 Mar 2004 12:05:50 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kernel 'simulator' and wave-form analysis tool?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wouldn't be surprised if someone's already done this, but...

I'm a chip designer, and when we design a chip, before we put it in 
silicon, we use simulator tools that emulate the logic we designed.  One 
of the most important parts of the simulator is the wave-form analyzer. 
  We run the simulator for some period of time, and then we can look at 
the history of every signal in the design.

Well, I've been looking at Bochs, and it has this 'instrumentation' 
facility which you can use to track everything that goes on in its 
simulation of an x86 processor.  If I were to put a hook in to track all 
memory writes, then I could record all memory activity (I could hook 
much more!).  When a crash occurs, someone could use the analogue to the 
wave-form tool to trace execution back to the event that caused the 
problem (because, for instance, heap corruption causes crashes much 
later than the bug).

Would it be a productive use of my time to work on this?

