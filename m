Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWI1QwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWI1QwZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbWI1QwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:52:25 -0400
Received: from 8.ctyme.com ([69.50.231.8]:23703 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S1751293AbWI1QwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:52:25 -0400
Message-ID: <451BFDC8.6030308@perkel.com>
Date: Thu, 28 Sep 2006 09:52:24 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.18 hangs during boot on ASUS M2NPV-VM motherboard
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok - I don't understand why this bug is being ignored. It appears that this bug applies to many models of motherboards all using the new nVidia chipset for AM2
socket AMD processors causing these motherboards to lock up on boot. This bug has been reported for a long time and it appears that there seems to be some
understanding as to what the problem is. Yet no one is fixing it.

So what's up with that? I know this is free software but I would think that someone would want to put out some effort to make Linux run on the AM2 systems.
So why is this being ignored?

I compiled 2.6.18 and setting acpi_skip_timer_override to 0 instead of 1 makes the problem go away. Obviously the logic needs to e a little more complex than
is but this shouldn't be that hard to resolve.

http://bugzilla.kernel.org/show_bug.cgi?id=6975




