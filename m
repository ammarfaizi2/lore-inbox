Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUAWAbr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 19:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266499AbUAWAbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 19:31:46 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:13735 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S266498AbUAWAaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 19:30:20 -0500
Message-ID: <065201c3e148$12ac1bf0$03c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
References: <20040122181751.A2101@mail.kroptech.com> <20040122162348.46637991.akpm@osdl.org>
Subject: Re: 2.6.1 oops in prune_dcache()
Date: Thu, 22 Jan 2004 19:29:46 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Adam Kropelin <akropel1@rochester.rr.com> wrote:
>>
>> At 4 AM this morning (during cron run, I suppose) a box running 2.6.1
>> hit the oops below. It locked solid, had to hit the reset button to
>> reboot it. The machine had been running 2.6.1 for about a week prior
>> with no problems.

<snip>

>> Jan 21 04:06:32 print kernel: eax: 00008000   ebx: c1dc83e0   ecx:
>> c577da74   edx: c577da74
>
> Bit 15 of %eax got flipped.  The kernel indexed off it and oopsed.
>
> This is most likely a hardware failure.

Yikes...I should have noticed that bit. You're certainly right. Guess I'm in
the market for some RAM. Sorry for the noise.

--Adam

