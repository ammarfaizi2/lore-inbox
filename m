Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131242AbQKIVDR>; Thu, 9 Nov 2000 16:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131273AbQKIVDH>; Thu, 9 Nov 2000 16:03:07 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:17412 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131242AbQKIVCs>;
	Thu, 9 Nov 2000 16:02:48 -0500
Message-ID: <3A0B10F3.32A14DF4@mandrakesoft.com>
Date: Thu, 09 Nov 2000 16:02:43 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Brian Gerst <bgerst@didntduck.org>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Module open() problems, Linux 2.4.0
In-Reply-To: <Pine.LNX.3.95.1001109154744.16836A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> I suppose. Look at what you just stated! This means that a reported
> value is now worthless.
> 
> To restate, somebody decided that we didn't need this reported value
> anymore. Therefore, it is okay to make it worthless.
> 
> I don't agree. The De-facto standard has been that the module usage
> count is equal to the open count. This became the standard because
> of a long established history.
> 
> This is one of the tools we use to verify that an entire system
> is functioning properly. Now, somebody decided that I didn't need
> this tool.

You assumed the module count == device open count, when that was in fact
never the case.  The 2.4.x kernel changes merely shattered false
assumptions you held on your part.

The kernel thread example I described in my last e-mail holds true for
kernel 2.2.x as well, maybe 2.0.x too.

	Jeff


-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
