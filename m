Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131993AbQKZXEh>; Sun, 26 Nov 2000 18:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130613AbQKZXE1>; Sun, 26 Nov 2000 18:04:27 -0500
Received: from [194.213.32.137] ([194.213.32.137]:6916 "EHLO bug.ucw.cz")
        by vger.kernel.org with ESMTP id <S131439AbQKZXEO>;
        Sun, 26 Nov 2000 18:04:14 -0500
Message-ID: <20001126232932.A4052@bug.ucw.cz>
Date: Sun, 26 Nov 2000 23:29:32 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrea Arcangeli <andrea@suse.de>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kernel_thread bogosity
In-Reply-To: <20001123232333.A6426@bug.ucw.cz> <20001124014830.I1461@athlon.random> <20001124205247.A141@bug.ucw.cz> <20001126172658.A5636@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20001126172658.A5636@athlon.random>; from Andrea Arcangeli on Sun, Nov 26, 2000 at 05:26:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > How can that work? restore_args ends with iret, anyway, and iret does
> > reload esp afaics...
> 
> ... only if there's an IPL change during the iret. Page 3-321 of 24319102.pdf
> from Intel:
> 
> 	[..] If the return is to another privilege level, the IRET instruction
> 	also pops the stack pointer and SS from the stack, before resuming
> 	program execution. [..]

Is this different on x86-64 in long mode?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
