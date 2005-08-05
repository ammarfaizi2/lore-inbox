Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263076AbVHETdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbVHETdz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 15:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbVHETbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 15:31:48 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:30739 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S263076AbVHETa6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 15:30:58 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050805185011.GL2241@redhat.com>
References: <1123234785.7889.7.camel@dhcp-192-168-22-217.internal> <Pine.LNX.4.63.0508051024100.559@excalibur.intercode> <1123260373.4471.8.camel@dhcp-192-168-22-217.internal> <Pine.LNX.4.61.0508051313050.5927@chaos.analogic.com> <20050805185011.GL2241@redhat.com>
X-OriginalArrivalTime: 05 Aug 2005 19:30:51.0969 (UTC) FILETIME=[30CC4310:01C599F4]
Content-class: urn:content-classes:message
Subject: Re: preempt with selinux NULL pointer dereference
Date: Fri, 5 Aug 2005 15:30:12 -0400
Message-ID: <Pine.LNX.4.61.0508051526570.6223@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: preempt with selinux NULL pointer dereference
thread-index: AcWZ9DDV8rogoMszRgO+L+Vtuzj4Xw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Dave Jones" <davej@redhat.com>
Cc: "Antoine Martin" <antoine@nagafix.co.uk>,
       "James Morris" <jmorris@namei.org>, <linux-kernel@vger.kernel.org>,
       "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Aug 2005, Dave Jones wrote:

> On Fri, Aug 05, 2005 at 01:19:40PM -0400, linux-os (Dick Johnson) wrote:
> >
> > > tsdev                   8832  0
> >    ^^^^___ This doesen't seem to be a "standard" module. Maybe
> > it doesn't have a GPL compatible "license string".
>
> Bzzzzzt.
>
> (linux-2.6.12)$ grep GPL drivers/input/tsdev.c
> MODULE_LICENSE("GPL");
>
> That's the touchscreen driver.
>
> 		Dave
>

Yep. Just nothing I recognized. Other stuff shown from `lsmod`
is pretty standard. It's possible he removed the offender, which
still leaves in /proc/sys/kernel/tainted non-zero.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
