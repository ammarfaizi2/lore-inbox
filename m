Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbWE2PIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWE2PIZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 11:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWE2PIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 11:08:25 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:57863 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751024AbWE2PIZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 11:08:25 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 29 May 2006 15:08:22.0681 (UTC) FILETIME=[BA2D6090:01C68331]
Content-class: urn:content-classes:message
Subject: Re: How to send a break?
Date: Mon, 29 May 2006 11:08:15 -0400
Message-ID: <Pine.LNX.4.61.0605291105550.21358@chaos.analogic.com>
In-Reply-To: <01b701c6818d$4bcd37b0$1800a8c0@dcccs>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to send a break?
Thread-Index: AcaDMbpMKhU1lQWgSLuCQLdpY8G0tA==
References: <01b701c6818d$4bcd37b0$1800a8c0@dcccs>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: =?iso-8859-2?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 27 May 2006, [iso-8859-2] Haar János wrote:

> Hello, list,
>
> I wish to know, how to send a "BREAK" to trigger the sysreq functions on the
> serial line, using echo.
>
> I mean like this:
>
> #!/bin/bash
> echo "?BREAK?" >/dev/ttyS0
> sleep 2
> echo "m" >/dev/ttyS0
>
> Thanks,
> Janos
>

Can't you use /proc/sysrq-trigger?

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.73 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
