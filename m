Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbVIFLiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVIFLiJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 07:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbVIFLiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 07:38:09 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:32523 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S964816AbVIFLiI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 07:38:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <809C13DD6142E74ABE20C65B11A2439809C4BD@www.telos.de>
References: <809C13DD6142E74ABE20C65B11A2439809C4BD@www.telos.de>
X-OriginalArrivalTime: 06 Sep 2005 11:38:06.0160 (UTC) FILETIME=[72AD4D00:01C5B2D7]
Content-class: urn:content-classes:message
Subject: Re: kbuild & C++
Date: Tue, 6 Sep 2005 07:38:05 -0400
Message-ID: <Pine.LNX.4.61.0509060728290.20278@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kbuild & C++
Thread-Index: AcWy13LRCXpYFnZJQEefjznx3Z1uUw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Budde, Marco" <budde@telos.de>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Sep 2005, Budde, Marco wrote:

> Hi,
>
> for one of our customers I have to port a Windows driver to
> Linux. Large parts of the driver's backend code consists of
> C++.
>
> How can I compile this code with kbuild? The C++ support
> (I have tested with 2.6.11) of kbuild seems to be incomplete /
> not working.
>
> cu, Marco
>
> Please send me a CC as e-mail.
>

The kernel is written in C and assembly. You need to port
the "kernel part" of your driver to C. Often windows "drivers"
are much more than "drivers" as known in Linux and Unix. They
often are the interface to another API such as LabVIEW,
Lab/Windows, CVI, etc., really an interface library. In
that case, the user-mode portion can be ported, often with
few changes, using C++.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
