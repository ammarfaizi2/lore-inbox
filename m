Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVDRQRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVDRQRf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 12:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVDRQRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 12:17:35 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:28393 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP id S262008AbVDRQRC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 12:17:02 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Kernel page table and module text
Date: Mon, 18 Apr 2005 09:17:01 -0700
Message-ID: <5F106036E3D97448B673ED7AA8B2B6B301D9185A@scl-exch2k.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel page table and module text
Thread-Index: AcVD3wpNTA5uU7PiQ6KR2iyXMdWzPwAUgWLg
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Allison" <fireflyblue@gmail.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Apr 2005 16:17:03.0415 (UTC) FILETIME=[0E9CFC70:01C54432]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Allison
>Sent: Sunday, April 17, 2005 11:21 PM
>To: linux-kernel@vger.kernel.org
>Subject: Kernel page table and module text
>
>Hi,
>
>Since module is loaded in non-contiguous memory, there has to be an
>entry in the kernel page table for all modules that are loaded on the
>system. I am trying to find entries corresponding to my module text in
>the page tables.
>
>I am not clear about how the kernel page table is organized after the
>system switches to protected mode.
>
>I printed out the page starting with swapper_pg_dir . But I do not
>find the addresses for all the modules loaded in the system.
>
>Do I still need to read the pg0 and pg1 pages ?
>
>If somebody can explain how to traverse the kernel page tables, that
>would be very helpful.
>
>thanks,
>Allison
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>

You can find some details here: 
http://www.csn.ul.ie/~mel/projects/vm/guide/pdf/understand.pdf

But whatever your purpose is, I doubt you would want to use PTEs.

Aleks.
