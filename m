Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284808AbRLLBC1>; Tue, 11 Dec 2001 20:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284812AbRLLBCR>; Tue, 11 Dec 2001 20:02:17 -0500
Received: from www3.aname.net ([62.119.28.103]:34691 "EHLO www3.aname.net")
	by vger.kernel.org with ESMTP id <S284808AbRLLBCH>;
	Tue, 11 Dec 2001 20:02:07 -0500
From: "Johan Ekenberg" <johan@ekenberg.se>
To: "Chris Mason" <mason@suse.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: SV: Lockups with 2.4.14 and 2.4.16
Date: Wed, 12 Dec 2001 02:01:25 +0100
Message-ID: <001001c182a8$8624a670$050010ac@FUTURE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2377.0
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
In-Reply-To: <2502410000.1008118058@tiny>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >## Kernel:
> >  - 2.4.14 and 2.4.16
> >  - Patched for reiserfs-quota with patches found at
> >    ftp://ftp.suse.com/pub/people/mason/patches/reiserfs/quota-2.4/
> >      ( * 50_quota-patch
> >        * dquota_deadlock
> >        * nesting
> >        * reiserfs-quota )
>
> For the 2.4.16 kernel, you used the quota patches from my 2.4.16 dir?

Yes.

> The fastest way to rule out filesystem deadlocks is to hook up a serial
> console and send me the decoded output of sysrq-t.

I'll look into this. A bit of a problem since there are 10 servers and you
never know which one is going to lockup next time. Do I really need 10 PC's
to monitor them simultaneously or could it be done more efficiently? I'm no
kernel hacker, any pointers as to what tools to use etc would be most
welcome.

Thanks,
/Johan Ekenberg

