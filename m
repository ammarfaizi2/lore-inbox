Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWBVU6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWBVU6n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWBVU6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:58:43 -0500
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:22685 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751450AbWBVU6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:58:42 -0500
Date: Wed, 22 Feb 2006 15:55:48 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: 2.6.16-rc4: ATI timer fix doesn't work
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Message-ID: <200602221558_MC3-1-B901-1B66@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2.6.16-rc4 I get this message on my Compaq v2312us notebook:

[    0.000000] ATI board detected. Using APIC/PM timer.

But the system clock still runs too fast.  Count for interrupt 0
increments; should it?

I need to use disable_timer_pin_1 to get normal timekeeping.
Shouldn't the message about shaky timers mention that?  And this
is a notebook but I never got that message...

-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert

