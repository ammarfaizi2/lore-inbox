Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbULLO2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbULLO2a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 09:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbULLO2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 09:28:30 -0500
Received: from webmail.sub.ru ([213.247.139.22]:43529 "HELO techno.sub.ru")
	by vger.kernel.org with SMTP id S262080AbULLO21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 09:28:27 -0500
From: Mikhail Ramendik <mr@ramendik.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Date: Sun, 12 Dec 2004 17:28:16 +0300
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412121728.16968.mr@ramendik.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

With kernel 2.6.10-rc3 and 256 M RAM, when I start a task taht eats a ot of 
RAM (for example, viewing a big TIFF file; also tested with a synthetic 
"eater"), in the resulting swapping process kswapd tahes quite a bit of CPU 
time. The computer becomes extremely unresponsive, the clock (in icewm) stops 
for periods of time up to a minute). And the task startup itself is somewhaat 
slow.

I have checked both 2.6.8.1 and 2.6.9 for comparison, and they fare a lot 
better. The CPU hogging is not there, the computer is much more responsive, 
and the task starts faster.

-- 
Yours, Mikhail Ramendik

