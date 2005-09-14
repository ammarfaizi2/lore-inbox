Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965216AbVINOgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965216AbVINOgz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 10:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965220AbVINOgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 10:36:55 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:40466 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S965216AbVINOgy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 10:36:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <17AB476A04B7C842887E0EB1F268111E026F9B@xpserver.intra.lexbox.org>
References: <17AB476A04B7C842887E0EB1F268111E026F9B@xpserver.intra.lexbox.org>
X-OriginalArrivalTime: 14 Sep 2005 14:36:52.0915 (UTC) FILETIME=[BFA03830:01C5B939]
Content-class: urn:content-classes:message
Subject: Re: Corrupted file on a copy
Date: Wed, 14 Sep 2005 10:36:52 -0400
Message-ID: <Pine.LNX.4.61.0509141033580.17510@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Corrupted file on a copy
Thread-Index: AcW5Ob/Ex6T+dbCAQNuBsgivuB/7TQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "David Sanchez" <david.sanchez@lexbox.fr>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Sep 2005, David Sanchez wrote:

> Hi,
>
> I'm using the linux kernel 2.6.10 and busybox 1.0 on a AMD AU1550 board.
>
> When I copy a big file (around 300M) within an ext2 filesystem (even on
> ext3 filesystem) then the output file is sometime "corrupted" (I mean
> that the source and the destination files are different and thus
> generate a different SHA1).
> Does somebody have a same behaviour?
>
> Thanks,
> David
>

Use `cmp` to compare the two files. You could have discovered
a bug in your checksum utility, you need to isolate it to
the file-system. FYI, I have never seen a copy of a file, including
the image of an entire DVD (saved to clone another), that was not
properly identical.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.53 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
