Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132912AbRADNMA>; Thu, 4 Jan 2001 08:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132950AbRADNLu>; Thu, 4 Jan 2001 08:11:50 -0500
Received: from [62.159.23.12] ([62.159.23.12]:34053 "EHLO mail.computerbild.de")
	by vger.kernel.org with ESMTP id <S132912AbRADNLh>;
	Thu, 4 Jan 2001 08:11:37 -0500
Message-ID: <012101c0764f$c8b2f840$7400a8c0@dukat.cb.de>
From: "Ingo T. Storm" <it@computerbild.de>
To: "Christian Loth" <chris@gidayu.max.uni-duisburg.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: DHCP Problems with 3com 3c905C Tornado
Date: Thu, 4 Jan 2001 14:11:00 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3612.1700
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3612.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  I recently installed a system with the 3c905C
>NIC on RedHat 6.2.

>  The freshly installed RedHat 6.2 worked nice
>and flawlessly,

>However after upgrading
>to the 2.2.16 RedHat Kernel RPMS, the DHCP negotiation
>no longer worked!

>I downloaded 2.2.18 proper. I compiled in the support
>for the card, but also: same result.

Have you checked conf.modules that now is modules.conf?

In my case rh had just renamed/aliased the device and as soon as I had
adapted modules.conf accordingly, the card worked.

Of course, I might have completely misunderstood the problem, but it
sounds a lot like what I saw...

Cheers,

Ingo



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
