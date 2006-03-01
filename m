Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWCANTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWCANTV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 08:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWCANTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 08:19:21 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:38413 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932298AbWCANTV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 08:19:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <503e0f9d0603010506x416e21e3o679a0b713f870a8a@mail.gmail.com>
x-originalarrivaltime: 01 Mar 2006 13:19:17.0782 (UTC) FILETIME=[BE594B60:01C63D32]
Content-class: urn:content-classes:message
Subject: Re: depmod kernel compilation
Date: Wed, 1 Mar 2006 08:19:17 -0500
Message-ID: <Pine.LNX.4.61.0603010813430.7753@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: depmod kernel compilation
Thread-Index: AcY9Mr5/vdKzPeWIRcOLdrUtqfWJvQ==
References: <503e0f9d0603010506x416e21e3o679a0b713f870a8a@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "tim tim" <tictactoe.tim@gmail.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 1 Mar 2006, tim tim wrote:

> hello.. i am trying to install 2.6.10 kernel.. and used the following..
>
> make xconfig -- selected lodable module support
> make bzImage
> make modules
> make modules_install
>
> then it show some depmod.. how can i install the kernel.. here i have
> a fully installed  RedHat EL3 os. 2.4.21...
>
> how figure it out

Going from 2.4.x to 2.6.x. make sure you have the latest modutils!
If not, install the latest, then do `make modules_install` again.
Then.....

`make install`

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
