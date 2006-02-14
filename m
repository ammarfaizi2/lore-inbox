Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030490AbWBNTEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030490AbWBNTEg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 14:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030592AbWBNTEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 14:04:36 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:17887 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1030490AbWBNTEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 14:04:35 -0500
Message-ID: <43F22985.4020800@cfl.rr.com>
Date: Tue, 14 Feb 2006 14:03:33 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: jzb@aexorsyst.com
CC: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: root=/dev/sda1 fails but root=0x0801 works...
References: <200602132316.15992.jzb@aexorsyst.com> <43F1FA74.80607@cfl.rr.com> <20060214162458.GD27946@ftp.linux.org.uk> <200602140920.20685.jzb@aexorsyst.com>
In-Reply-To: <200602140920.20685.jzb@aexorsyst.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Feb 2006 19:05:48.0800 (UTC) FILETIME=[AA90A000:01C63199]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14267.000
X-TM-AS-Result: No--8.700000-5.000000-4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Z. Bohach wrote:
> Thanks for the info...Philip, you are correct, but for the wrong reason.  Al,
> you hit it right on the head...
>
> It is intentional behavior, but the reason is that
> for name_to_dev_t() to work, CONFIG_SYSFS must be enabled...so there's
> my connection to the CONFIG_* option that I suspected...
>
> Thanks again...
>   

I see, I wonder when that got added.  Does there happen to be a way to 
turn that off, but keep sysfs?  Since I use an initramfs ( ubuntu ) 
there is no need for the kernel to contain such code.  I wonder what 
other bits of code could be removed when you use an initramfs?


