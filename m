Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264527AbUD2Nom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264527AbUD2Nom (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 09:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbUD2Nom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 09:44:42 -0400
Received: from hellhawk.shadowen.org ([212.13.208.175]:41997 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S264527AbUD2Noi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 09:44:38 -0400
Date: Thu, 29 Apr 2004 14:49:19 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: =?ISO-8859-1?Q?Mariusz_Koz=B3owski?= <sp3fxc@linuxfocus.org>,
       john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: odd clock thing...
Message-ID: <18827512.1083250159@42.150.104.212.access.eclipse.net.uk>
In-Reply-To: <200404101526.10695.sp3fxc@linuxfocus.org>
References: <200404062004.22292.sp3fxc@linuxfocus.org>
 <1081363155.5408.455.camel@cog.beaverton.ibm.com>
 <200404101526.10695.sp3fxc@linuxfocus.org>
X-Mailer: Mulberry/3.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On 10 April 2004 15:26 +0200 Mariusz Koz³owski <sp3fxc@linuxfocus.org>
wrote:

> 	I did what you told me to do. I disabled ACPI PM time source. There is a 
> significant change. The system clock is running still too fast but it is
> a  very small difference. After 24 hours the difference is 2 minutes
> ahead. I  don't know what to think about it. Is it precise enough or
> should I do some  more tests. As far as I remember the system clock on
> this machine was runnig  perfectly fine so that even after one week it
> was still in sync with other  electronic clocks I have. I think I'll try
> to disable CPUfreq and see if it  helps. 

I think if your system clock is as good as 2 minutes per day you are
'normal'.  System clocks are generally very stable but not very accurate,
ie. they will consistently gain or lose the same ammount per day, but not
be that good.  That is one of the reasons NTP is very effective on a
system, it can figure out how rubbish your clock is and correct for it
because of that stability.

-apw
