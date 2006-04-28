Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030478AbWD1Q23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030478AbWD1Q23 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 12:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbWD1Q23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 12:28:29 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:23997 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030478AbWD1Q22
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 12:28:28 -0400
From: Vernon Mauery <vernux@us.ibm.com>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.16-rt18] machine stops before reboot
Date: Fri, 28 Apr 2006 09:28:26 -0700
User-Agent: KMail/1.8.3
Cc: Ingo Molnar <mingo@elte.hu>
References: <200604280912.24578.vernux@us.ibm.com>
In-Reply-To: <200604280912.24578.vernux@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604280928.26996.vernux@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 April 2006 09:12, Vernon Mauery wrote:
> Ingo,
>
> On the Intellistation and LS-20 configuration I just reported the irqpoll
> bug about, if we don't use irqpoll to boot and it actually boots up and
> things seem to be working fine, when we go to reboot, it doesn't ever
> completely shut down:
...
> Shutting down loopback interface:  [  OK  ]
> Starting killall:  [  OK  ]
> Sending all processes the TERM signal...
>
> And it gets stuck here.  That machine is not dead or hung.  I can type
> stuff and it shows up on the terminal, but it does not seem to be running
> anything. I can reboot it with the sysrq keys.
>
> I tested this against 2.6.16-rt16 and I haven't seen this problem after
> about 6 reboots.  So I think this is a regression.

Right after I sent this email, 2.6.16-rt16 got stuck at the next step:
Sending all processes the KILL signal... 

So maybe this is a long standing problem?

--Vernon

>
> --Vernon
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
