Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbTKDMgM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 07:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbTKDMgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 07:36:12 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:7860 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S261606AbTKDMgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 07:36:11 -0500
Message-ID: <3FA79D3A.8090308@softhome.net>
Date: Tue, 04 Nov 2003 13:36:10 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.4] Are jiffies in jiffies?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   [ I beleive this is real FAQ - so responding with private e-mails 
more appropriate.
     ptr("RTFM") != 0 are welcome. ]

   jiffies declared in kernel/timer.c.
   Name suggests that it is incremented 100 times per second.
   LDD2 suggests that it is incremented every 1000/HZ per second.

   Is it just name misleading - or I really miss the point?

   So to translate this to seconds i need (jiffies*1000/HZ)
   and milliseconds are just (jiffies/HZ) then.

   Am I right?
   I need this for {add,mod}_timer() calls.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  "... and for $64000 question, could you get yourself       |_|*|_|
    vaguely familiar with the notion of on-topic posting?"   |_|_|*|
                                 -- Al Viro @ LKML           |*|*|*|

