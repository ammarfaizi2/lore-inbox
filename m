Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161135AbVICFP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161135AbVICFP3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 01:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161138AbVICFP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 01:15:29 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:40420 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1161135AbVICFP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 01:15:28 -0400
Message-ID: <43193169.3090801@comcast.net>
Date: Sat, 03 Sep 2005 01:15:21 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: vatsa@in.ibm.com, linux-kernel@vger.kernel.org, arjan@infradead.org,
       s0348365@sms.ed.ac.uk, kernel@kolivas.org, tytso@mit.edu,
       cfriesen@nortel.com, trenn@suse.de, george@mvista.com,
       johnstul@us.ibm.com, akpm@osdl.org
Subject: Re: [PATCH 1/3] Updated dynamic tick patches - Fix lost tick	calculation
 in timer_pm.c
References: <20050831165843.GA4974@in.ibm.com>	 <20050831171211.GB4974@in.ibm.com> <1125720301.4991.41.camel@mindpipe>
In-Reply-To: <1125720301.4991.41.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

> Are lost ticks really that common? If so, any idea what's disabling
>
>interrupts for so long (or if it's a hardware issue)?  And if not, it
>seems like you'd need an artificial way to simulate lost ticks in order
>to test this stuff.
>
>Lee
>  
>
Yes - I know many people with laptops who have this lost ticks problem. 
So no simulation and/or
special efforts required.  If anyone wants a test bed - my laptop is the 
perfect instrument.

In my case the rip is always as acpi_processor_idle now a days. Earlier 
it used to be at acpi_ec_read.

Parag
