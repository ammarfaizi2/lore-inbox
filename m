Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283006AbRLTJsO>; Thu, 20 Dec 2001 04:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282640AbRLTJrz>; Thu, 20 Dec 2001 04:47:55 -0500
Received: from camus.xss.co.at ([194.152.162.19]:21772 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S282702AbRLTJrq>;
	Thu, 20 Dec 2001 04:47:46 -0500
Message-ID: <3C21B3BF.9AFA674A@xss.co.at>
Date: Thu, 20 Dec 2001 10:47:43 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Deadlock: Linux-2.2.18, sym53c8xx, Compaq ProLiant, HP Ultrium
In-Reply-To: <3C2121B8.1030702@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Thank you for your reply!

Manfred Spraul wrote:
> 
> >
> >
> >   After that, the amanda process hangs in state "D" and
> >   cannot be killed anymore. The machine itself is still
> >   working.
> >
> >
> If something is stuck in D state, always try sysrq-T.
> This dumps the kernel stack of all processes. Check that the stuck
> process is logged (the kernel log can overflow if many processes are
> running), then parse the result through ksymoops.
> This shows you/us where it stuck.
> 
Well, I know that. But as I mentioned im my mail, the
machine currently runs "headless" (no keyboard, no monitor).
And it's running in a server room several kilometers away 
from my office...

I decided to try a different SCSI controller first.
We'll see then how it works...

Regards,

- andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
