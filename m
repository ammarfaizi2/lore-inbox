Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWJFR3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWJFR3P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 13:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWJFR3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 13:29:15 -0400
Received: from hqemgate01.nvidia.com ([216.228.112.170]:36937 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S1750743AbWJFR3P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 13:29:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: forcedeth net driver: reverse mac address after pxe boot
Date: Fri, 6 Oct 2006 10:29:04 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B0189CAB16@hqemmail02.nvidia.com>
In-Reply-To: <55c223960610060737p1a5fda6bl95547accc7d96468@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: forcedeth net driver: reverse mac address after pxe boot
Thread-Index: AcbpVOp/gGl9q+01TE+6rEXE+WGFGgAF9unA
From: "Ayaz Abdulla" <AAbdulla@nvidia.com>
To: "Alex Owen" <r.alex.owen@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Oct 2006 17:29:04.0767 (UTC) FILETIME=[EBC0F8F0:01C6E96C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has been fixed in version "243.0537". You will have to request an
updated BIOS from your board vendor.

Regards,
Ayaz


-----Original Message-----
From: Alex Owen [mailto:r.alex.owen@gmail.com] 
Sent: Friday, October 06, 2006 7:37 AM
To: Ayaz Abdulla
Cc: linux-kernel@vger.kernel.org
Subject: Re: forcedeth net driver: reverse mac address after pxe boot


On 05/10/06, Ayaz Abdulla <AAbdulla@nvidia.com> wrote:
> The BIOS will write to the mac address register. The address will be
> written in reverse order.
(Why does the BIOS have to write it out in reverse order? Seems a bit
odd to my simple mind!)

> This bug has already been fixed in the PXE code. Can you let me know
> what version of PXE you are running (it should display the version on
> the screen during boot up)?
I was booting with "Nvidia Boot Agent 240.0532" when I encountered this
issue.

Alex Owen
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
