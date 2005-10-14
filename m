Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbVJNSzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbVJNSzZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 14:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbVJNSzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 14:55:25 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:64779 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750878AbVJNSzZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 14:55:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20051014113247.153cc5cc.akpm@osdl.org>
References: <200510141350_MC3-1-ACA0-C8C9@compuserve.com><Pine.LNX.4.61.0510141409040.4395@chaos.analogic.com> <20051014113247.153cc5cc.akpm@osdl.org>
X-OriginalArrivalTime: 14 Oct 2005 18:55:19.0679 (UTC) FILETIME=[D2C520F0:01C5D0F0]
Content-class: urn:content-classes:message
Subject: Re: [patch 2.6.14-rc4] i386: spinlock optimization
Date: Fri, 14 Oct 2005 14:55:18 -0400
Message-ID: <Pine.LNX.4.61.0510141454550.4499@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.14-rc4] i386: spinlock optimization
Thread-Index: AcXQ8NLrPBHfgnuRQTGEb0wypCQedw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <76306.1226@compuserve.com>, <linux-kernel@vger.kernel.org>, <ak@suse.de>,
       <torvalds@osdl.org>, <mingo@elte.hu>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Oct 2005, Andrew Morton wrote:

> "linux-os \(Dick Johnson\)" <linux-os@analogic.com> wrote:
>>
>>  Somehow, these spin-locks got all screwed up.
>>
>>  Given: nobody has the lock. The lock variable is 0.
>
> Unlocked locks have .raw_lock.slock = 1, not 0.
>

Hmmm. Okay. Doesn't that add more code?


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.46 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
