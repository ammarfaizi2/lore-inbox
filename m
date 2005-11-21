Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbVKUPtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbVKUPtb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 10:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbVKUPta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 10:49:30 -0500
Received: from 8.ctyme.com ([69.50.231.8]:11429 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S932327AbVKUPta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 10:49:30 -0500
Message-ID: <4381EC88.6060605@perkel.com>
Date: Mon, 21 Nov 2005 07:49:28 -0800
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: James Courtier-Dutton <James@superbug.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Does Linux support powering down SATA drives?
References: <437F63C1.6010507@perkel.com> <437FCA07.40600@superbug.co.uk> <4381EB1B.5040105@rtr.ca>
In-Reply-To: <4381EB1B.5040105@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mark Lord wrote:

> Yes, the hdparm -y, -Y, and -S flags all work with the passthru 
> feature set,
> which is included in the 2.6.15-rc* kernels.
>
> Typical power consumption figures, from WDC SataII drives:
>
> Idle:  430mA@12VDC + 730mA@5VDC (about 8.75 watts)
> Standby:  20mA@12VDC + 270mA@5VDC (about 1.60 watts)
> Sleep: 20mA@12VDC + 250mA@5VDC (about 1.50 watts)
>
> Those are from the WDC datasheets.
>
> Cheers


Here's maxotor specs

Power
Spinup (avg, watts) 28.7
Seek (avg, watts) 12.3
Idle (avg, watts) 7.0
Standby (avg, watts) 2.1

-- 
Marc Perkel - marc@perkel.com

Spam Filter: http://www.junkemailfilter.com
    My Blog: http://marc.perkel.com

