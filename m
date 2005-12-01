Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751719AbVLAULp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbVLAULp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 15:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVLAULp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 15:11:45 -0500
Received: from spirit.analogic.com ([204.178.40.4]:273 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751719AbVLAULo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 15:11:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20051123233016.4a6522cf.pj@sgi.com>
X-OriginalArrivalTime: 01 Dec 2005 20:01:19.0789 (UTC) FILETIME=[FF01F5D0:01C5F6B1]
Content-class: urn:content-classes:message
Subject: Re: Use enum to declare errno values
Date: Thu, 1 Dec 2005 15:01:18 -0500
Message-ID: <Pine.LNX.4.61.0512011458280.21933@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Use enum to declare errno values
Thread-Index: AcX2sf8LNmRxK7qfS6a5LKScuUtR9Q==
References: <20051123132443.32793.qmail@web25813.mail.ukl.yahoo.com><200511231624.49208.vda@ilport.com.ua><Pine.LNX.4.61.0511230958550.18085@chaos.analogic.com><200511240919.52650.vda@ilport.com.ua> <20051123233016.4a6522cf.pj@sgi.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Paul Jackson" <pj@sgi.com>
Cc: "Denis Vlasenko" <vda@ilport.com.ua>, <francis_moreau2000@yahoo.fr>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Nov 2005, Paul Jackson wrote:

> If errno's were an enum type, what would be the type
> of the return value of a variety of kernel routines
> that now return an int, returning negative errno's on
> error and zero or positive values on success?
>

enums are 'integer types', one of the reasons why #defines
which are also 'integer types' are just as useful. If you
want to auto-increment these integer types, then enums are
useful. Otherwise, just use definitions.

> --
>                  I won't rest till it's the best ...
>                  Programmer, Linux Scalability
>                  Paul Jackson <pj@sgi.com> 1.925.600.0401
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
