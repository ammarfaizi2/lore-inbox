Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751790AbWG1Bzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbWG1Bzo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 21:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbWG1Bzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 21:55:44 -0400
Received: from msr43.hinet.net ([168.95.4.143]:42634 "EHLO msr43.hinet.net")
	by vger.kernel.org with ESMTP id S1751790AbWG1Bzn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 21:55:43 -0400
Message-ID: <040401c6b1e8$e8b14ae0$4964a8c0@icplus.com.tw>
From: "Jesse Huang" <jesse@icplus.com.tw>
To: "Francois Romieu" <romieu@fr.zoreil.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Jeff Garzik" <jgarzik@pobox.com>
References: <02fb01c6b147$b15b8fc0$4964a8c0@icplus.com.tw> <20060727190707.GA24157@electric-eye.fr.zoreil.com>
Subject: Re: Hello, We have IP100A Linux driver need to submit to 2.6.x kernel
Date: Fri, 28 Jul 2006 09:55:31 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francois:

    Sorry, I don't know this patch before. IP100A is a new version of IP100
(sundance.c). I don't know what is you suggestion of IP100A driver? Should
I...

1. Only updata sundance.c to support IP100A
2. Release ip100a.c which support ip100(sundance) to kernel 2.6.x and ask to
remove sundance.c.
3. Release ip100a.c with sundance.c both to kernel 2.6.x

We hope to use IP100a.c as our product driver, so 2. and 3. will better for
IC Plus. But we will still follow your suggestion, if you feel 1. was better
for kernel.

Thanks!

Jesse

----- Original Message ----- 
From: "Francois Romieu" <romieu@fr.zoreil.com>
To: "Jesse Huang" <jesse@icplus.com.tw>
Cc: <linux-kernel@vger.kernel.org>; <netdev@vger.kernel.org>; "Andrew
Morton" <akpm@osdl.org>; "Jeff Garzik" <jgarzik@pobox.com>
Sent: Friday, July 28, 2006 3:07 AM
Subject: Re: Hello, We have IP100A Linux driver need to submit to 2.6.x
kernel


Jesse Huang <jesse@icplus.com.tw> :
[...]
> I am IC Plus software engineer. We have IP100A 10/100 fast network adapter
> driver need to submit to Linux 2.6.x kernel. Please tell me who should I
> submit to.
>
> IP100A's device ID is 0x13f0 0200.

You do not need to do anything:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1668b19f75cb949f930814a23b74201ad6f76a53

As far as I have checked before forwarding Pedro Alejandro's patch, the
out-of-tree IP100 driver exhibited no significant difference with the
sundance driver.

-- 
Ueimor


