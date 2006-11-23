Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933766AbWKWPXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933766AbWKWPXo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 10:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933774AbWKWPXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 10:23:44 -0500
Received: from mx27.mail.ru ([194.67.23.64]:19062 "EHLO mx27.mail.ru")
	by vger.kernel.org with ESMTP id S933766AbWKWPXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 10:23:43 -0500
Message-ID: <4565BC7E.3020406@mail.ru>
Date: Thu, 23 Nov 2006 18:21:34 +0300
From: realales <realales@mail.ru>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrei <realales@mail.ru>
Subject: Scenario passes on 2.6.15.26 but fails on 2.6.11.4-20a kernel
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear experts,

a problem happen on Suse9.3 with 2.6.11.4-20a kernel.
But  the same scenario perfectly works on Ubuntu with 2.6.15.26 kernel.

I already asked this question on x.org (as it sounds bit closer to the 
issue) but there is still no response.

Well, I'm trying to use XTestFakeButtonEvent(args) from XTEST extension 
(it allows to emulate user input) and pass there buttons like 1, 2, 3, 
4, 5, etc.

The problem that only 1-5 buttons does work, 6 and 7 doesn't.
Seem XTEST is just trying to go deeper through xorg into kernel.
I tired to figure out what's the difference in kernel configuration 
("make menuconfig") but seem they are the same or I missed something there.

Also I analyzed XTEST sources without any success.
I know that this is unlikely the right place to ask this but could 
someone please point me on the right way to move further?! Or may it be 
already a know problem for somebody?

Interestingly that I may use all buttons 1-7 if use mouse by hand. The 
only problem when using it in program.
I wouldn't like to upgrade the kernel to check whether that solves the 
problem. :)

Thanks in advance,
  --Andrei

