Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130644AbRCLVVO>; Mon, 12 Mar 2001 16:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130661AbRCLVVE>; Mon, 12 Mar 2001 16:21:04 -0500
Received: from f88.law10.hotmail.com ([64.4.15.88]:12296 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S130644AbRCLVUx>;
	Mon, 12 Mar 2001 16:20:53 -0500
X-Originating-IP: [209.191.34.210]
From: "Chip Rodden" <chip_rodden@hotmail.com>
To: jbrosnan@asitatech.ie, tulip@scyld.com, linux-kernel@vger.kernel.org
Subject: Re: [tulip] Linux 2.2.16/Tulip Smartbits testing.
Date: Mon, 12 Mar 2001 21:20:21 -0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F88SMmGB7Wz4e9StHov000115fc@hotmail.com>
X-OriginalArrivalTime: 12 Mar 2001 21:20:22.0027 (UTC) FILETIME=[3F074DB0:01C0AB3A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John,

It's the driver.  We have been doing smartbits testing for more
than a year and found the same results as you appear to be getting.
The driver just dies and never recovers.  It attempts to do
interrupt mitigation(coalescing) but that appears to be useless.

The solution is to write a new driver which is what we have done
here...

Chip
_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

