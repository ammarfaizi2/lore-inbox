Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbUDJNXj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 09:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbUDJNXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 09:23:39 -0400
Received: from dial-4024.zgora.dialog.net.pl ([81.168.236.184]:4 "EHLO
	linuxfocus.org") by vger.kernel.org with ESMTP id S262019AbUDJNXh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 09:23:37 -0400
From: Mariusz =?iso-8859-2?q?Koz=B3owski?= <sp3fxc@linuxfocus.org>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: odd clock thing...
Date: Sat, 10 Apr 2004 15:26:10 +0200
User-Agent: KMail/1.6.1
References: <200404062004.22292.sp3fxc@linuxfocus.org> <1081363155.5408.455.camel@cog.beaverton.ibm.com>
In-Reply-To: <1081363155.5408.455.camel@cog.beaverton.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404101526.10695.sp3fxc@linuxfocus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia ¶ro 7. kwietnia 2004 20:39, napisa³e¶:
> Very odd. I looked at the dmesg you sent me and it looks like you're
> using the ACPI PM timesource. There is an open bug (link below) against
> it and I'm not sure if we're dealing with odd hardware or some other
> side effect is causing the issue.
>
> If you disable cpufreq does it go away? You might want to try disabling
> the ACPI PM timer code (under the Power Management->ACPI menu) and see
> if that resolves it.
>
> For more details, check this bug:
> http://bugme.osdl.org/show_bug.cgi?id=2375

Hi John,

	I did what you told me to do. I disabled ACPI PM time source. There is a 
significant change. The system clock is running still too fast but it is a 
very small difference. After 24 hours the difference is 2 minutes ahead. I 
don't know what to think about it. Is it precise enough or should I do some 
more tests. As far as I remember the system clock on this machine was runnig 
perfectly fine so that even after one week it was still in sync with other 
electronic clocks I have. I think I'll try to disable CPUfreq and see if it 
helps. 

Thanks for helping out,

	Mariusz
