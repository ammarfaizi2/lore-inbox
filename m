Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264954AbTAWIkE>; Thu, 23 Jan 2003 03:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264969AbTAWIkE>; Thu, 23 Jan 2003 03:40:04 -0500
Received: from [202.54.64.7] ([202.54.64.7]:13836 "EHLO hclnpd.hclt.co.in")
	by vger.kernel.org with ESMTP id <S264954AbTAWIkD>;
	Thu, 23 Jan 2003 03:40:03 -0500
Message-ID: <3E2FA9E6.110F0304@npd.hcltech.com>
Date: Thu, 23 Jan 2003 14:07:58 +0530
From: Narsimha Reddy CH <creddy@npd.hcltech.com>
Reply-To: creddy@npd.hcltech.com
Organization: HCL Technologies Ltd.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Sanders <developer_linux@yahoo.com>
CC: redhat-list@redhat.com, linux-kernel@vger.kernel.org,
       redhat-devel-list@redhat.com
Subject: Re: Linux application level timers?
References: <20030122221703.42913.qmail@web9806.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can also use the poll() system call. The last arguement
of this system call is the timeout value is milli-seconds.
When timeout is occurred it will return 0. Refer the
manual page for more details.

hope this helps you,
-- 
Narsimha Reddy CH
Storage Area Networking, HCL Technologies
Contact  +91-044 2372 8366 ext 1128

http://san.hcltech.com
http://www.hcltech.com



Tom Sanders wrote:
> 
> I'm writing an application server which receives
> requests from other applications. For each request
> received, I want to start a timer so that I can fail
> the application request if it could not be completed
> in max specified time.
> 
> Which Linux timer facility can be used for this?
> 
> I have checked out alarm() and signal() system calls,
> but these calls doesn't take an argument, so its not
> possible to associate application request with the
> matured alarm.
> 
> Any inputs?
> 
> Thanks in advance,
> Tom
> 
> __________________________________________________
> Do you Yahoo!?
> Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
> http://mailplus.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
