Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422964AbWJFVDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422964AbWJFVDK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 17:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422970AbWJFVDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 17:03:10 -0400
Received: from hqemgate01.nvidia.com ([216.228.112.170]:53554 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S1422964AbWJFVDJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 17:03:09 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: forcedeth net driver: reverse mac address after pxe boot
Date: Fri, 6 Oct 2006 14:02:58 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B0189CAB1A@hqemmail02.nvidia.com>
In-Reply-To: <20061006191115.GA21526@tuxdriver.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: forcedeth net driver: reverse mac address after pxe boot
Thread-Index: Acbpez5yNf5zr9/MSfusBDaU2LxclAADymLw
From: "Ayaz Abdulla" <AAbdulla@nvidia.com>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: "Alex Owen" <r.alex.owen@gmail.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Oct 2006 21:02:58.0851 (UTC) FILETIME=[CD76C730:01C6E98A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is just a legacy bug that we have to live with. Newer chipsets will
have the correct format in the BIOS.

With the latest forcedeth driver and latest PXE you should not have any
issues.

Regards,
Ayaz


-----Original Message-----
From: John W. Linville [mailto:linville@tuxdriver.com] 
Sent: Friday, October 06, 2006 12:12 PM
To: Ayaz Abdulla
Cc: Alex Owen; linux-kernel@vger.kernel.org
Subject: Re: forcedeth net driver: reverse mac address after pxe boot


On Fri, Oct 06, 2006 at 10:29:04AM -0700, Ayaz Abdulla wrote:
> This has been fixed in version "243.0537". You will have to request an
> updated BIOS from your board vendor.

Ayaz,

Can you explain the whole "reverse-order MAC address" thing?
Why/how does it end-up in that register backwards in the first place?
Does it serve some purpose that way?  Or is it just a bug that we
have to live with?

John
-- 
John W. Linville
linville@tuxdriver.com
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
