Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWH2UYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWH2UYV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 16:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbWH2UYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 16:24:21 -0400
Received: from spirit.analogic.com ([204.178.40.4]:20493 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S964803AbWH2UYV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 16:24:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
x-originalarrivaltime: 29 Aug 2006 20:24:18.0189 (UTC) FILETIME=[1A8B5BD0:01C6CBA9]
Content-class: urn:content-classes:message
Subject: ptrace: umoven:
Date: Tue, 29 Aug 2006 16:24:17 -0400
Message-ID: <Pine.LNX.4.61.0608291610310.9209@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ptrace: umoven:
Thread-Index: AcbLqRqxhSBNKrSyStOWDIJuFKo2NA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I googled 'umoven' and see that lots of people have reported
this problem, but I don't see any solution.
How do I get rid of the 'umoven' error when `stracing` system calls?

Typically:
open("/home/cat3/work/view.dat", O_RDONLY) = 4
read(4, ptrace: umoven: Input/output error
0xa1b6d000, 41884)              = 41884
read(4, ptrace: umoven: Input/output error
0xa1b7739c, 41884)              = 41884
read(4, ptrace: umoven: Input/output error
0xa1b81738, 41884)              = 41884
read(4, ptrace: umoven: Input/output error
0xa1b8bad4, 41884)              = 41884

The read actually succeeds, but ptrace doesn't like it.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
