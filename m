Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313987AbSDQAyy>; Tue, 16 Apr 2002 20:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313988AbSDQAyx>; Tue, 16 Apr 2002 20:54:53 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:65177 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S313987AbSDQAyx>; Tue, 16 Apr 2002 20:54:53 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 16 Apr 2002 18:02:17 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: davidm@hpl.hp.com, Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Why HZ on i386 is 100 ?
In-Reply-To: <794826DE8867D411BAB8009027AE9EB913D03D4C@FMSMSX38>
Message-ID: <Pine.LNX.4.44.0204161754500.1460-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2002, Chen, Kenneth W wrote:

> If you change HZ to 1000, you need to change PROC_CHANGE_PENALTY
> accordingly.  Otherwise, process would get preempted before its time slice
> gets expired.  The net effect is more context switch than necessary, which
> could explain the 10% difference.

that might be the case. i was not running the latsched sampler during that
test, that would have helped me in detecting extra task bounces/cs



- Davide



