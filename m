Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263113AbRE1SAA>; Mon, 28 May 2001 14:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263115AbRE1R7u>; Mon, 28 May 2001 13:59:50 -0400
Received: from smtp5vepub.gte.net ([206.46.170.26]:57700 "EHLO
	smtp5ve.mailsrvcs.net") by vger.kernel.org with ESMTP
	id <S263113AbRE1R7h>; Mon, 28 May 2001 13:59:37 -0400
From: George France <france@handhelds.org>
Date: Mon, 28 May 2001 13:59:27 -0400
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>
To: Jay Thorne <Yohimbe@userfriendly.org>
In-Reply-To: <990827407.27355.2.camel@gracie.userfriendly.org> <01052523163402.28075@shadowfax.middleearth> <991071923.25870.0.camel@gracie.userfriendly.org>
In-Reply-To: <991071923.25870.0.camel@gracie.userfriendly.org>
Subject: Re: [SOLVED] PROBLEM: Alpha SMP Low Outbound Bandwidth
MIME-Version: 1.0
Message-Id: <01052813592702.17841@shadowfax.middleearth>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 May 2001 13:45, Jay Thorne wrote:
> Problem solved, thanks to the rawhide patch from Richard Henderson
> (rth@twiddle.net) posted on Sunday. Performance is ~10megs/second both
> directions, using tulip, de4x5 or via-rhine.

Well Done, Richard.

>
> Using 2.4.4-ac15 it works fine. I'm now trying 2.4.5
>
> Andrea, 2.4.5aa1 oopses just after probing the scsi cards. I've tried
> the 2.4.4 series aa patches and had similar failure on boot.
>
> Its too fast to see the error, so I'm building a serial console version
> to capture it. Is an easy way to tell an alpha to stop dead so I can
> copy the oops?

try adding 'console=ttyS0,9600 console=tty0' to the comand line args passed 
to the kernel at boot time.  if you are using  SRM and aboot, 'b <dev> -fl i' 
followed by the 'l' command, then a 'b' command.

regards,


--George
