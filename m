Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278484AbRJVKPx>; Mon, 22 Oct 2001 06:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278485AbRJVKPo>; Mon, 22 Oct 2001 06:15:44 -0400
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:16905 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S278484AbRJVKPd>; Mon, 22 Oct 2001 06:15:33 -0400
Message-ID: <NPHLGxZPH$07EwlQ@wookie.demon.co.uk>
Date: Mon, 22 Oct 2001 11:15:43 +0100
To: linux-kernel@vger.kernel.org
From: John Beardmore <wookie@wookie.demon.co.uk>
Subject: ISDN cards and SMP
MIME-Version: 1.0
Content-Type: text/plain;charset=us-ascii;format=flowed
User-Agent: Turnpike/6.00-U (<F7naP4S4l2F1q+EHsIexcg5ozp>)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried using a Sedlbauer speedcard ISDN controller under Alpha
RH6.2.

This works fine with a single processor kernel, but the module fails to
load with a kernel compiled for SMP.

I gather this is true for all the Isdn4Linux drivers, though as I have a
three processor machine, this is a real pain !

Advice seems to be to get an external TA of some kind, but that would
seem likely to add to ping times, and maybe to create a bottleneck if I
ever get 128k or compression to my ISP !

So, two questions:

  1) are there any fixes for this problem in the pipeline

and if not,

  2) how easy would it be for the kernel novice to adapt a uniprocessor
     driver to survive in the SMP environment ?


Cheers, J/.
-- 
John Beardmore
