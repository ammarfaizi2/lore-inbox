Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVK1I3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVK1I3y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 03:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbVK1I3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 03:29:54 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:15507 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S932125AbVK1I3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 03:29:53 -0500
From: Duncan Sands <duncan.sands@free.fr>
To: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: speedtch driver, 2.6.14.2
Date: Mon, 28 Nov 2005 09:29:56 +0100
User-Agent: KMail/1.8.3
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
References: <200511232125.25254.s0348365@sms.ed.ac.uk> <m3mzjp3dgu.fsf@defiant.localdomain>
In-Reply-To: <m3mzjp3dgu.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511280929.56230.duncan.sands@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 November 2005 23:58, Krzysztof Halasa wrote:
> Alistair John Strachan <s0348365@sms.ed.ac.uk> writes:
> 
> > However, on my rev 4.0 Speedtouch 330, I periodically get the message:
> >
> > ATM dev 0: error -110 fetching device status
> 
> Same here.
> 
> defiant:~$ dmesg | grep 'ATM dev 0: error -110 fetching device status' | wc -l
> 55
> defiant:~$ uptime
>  23:55:40 up 15 days, 23:34,  6 users,  load average: 0.05, 0.06, 0.06
> 
> It works fine, though.

If you unplug the phone line and plug it back in again, does the line
resynchronize?  Does the driver detect that the line is back up?

Thanks,

D.
