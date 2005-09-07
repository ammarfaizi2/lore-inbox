Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbVIGMHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbVIGMHd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 08:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVIGMHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 08:07:33 -0400
Received: from spirit.analogic.com ([208.224.221.4]:9733 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751204AbVIGMHc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 08:07:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <431ED4C1.6020406@bizmail.com.au>
References: <431ED4C1.6020406@bizmail.com.au>
X-OriginalArrivalTime: 07 Sep 2005 12:07:31.0140 (UTC) FILETIME=[B919A040:01C5B3A4]
Content-class: urn:content-classes:message
Subject: Re: system IPC
Date: Wed, 7 Sep 2005 08:07:30 -0400
Message-ID: <Pine.LNX.4.61.0509070805430.7221@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: system IPC
Thread-Index: AcWzpLk9dB8tc1SkR0OaOGhPgRckQA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "YH" <yh@bizmail.com.au>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Sep 2005, YH wrote:

> It seems that the kernel disallows drivers to use system IPC.
> Asynchronous communication mechanism is very effective mechanism among
> various embedded OSes, even popular in RTOSes. Any reason why cannot use
> sys_msgsnd and sys_msgrcv for kernel drivers?
>

Because they were not designed for use inside the kernel.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
