Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbTDGBRt (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 21:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263177AbTDGBRt (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 21:17:49 -0400
Received: from fmr02.intel.com ([192.55.52.25]:23789 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S263178AbTDGBRr (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 21:17:47 -0400
Subject: Re: Re: [PATCH][RESEND] socket interface for IPMI against 2.5.66-bk
From: Louis Zhuang <louis.zhuang@linux.co.intel.com>
To: Corey Minyard <minyard@acm.org>
Cc: OPENIPMIML <openipmi-developer@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3E8D9CD2.8060506@acm.org>
References: <1049363835.1168.6.camel@hawk.sh.intel.com>
	 <3E8C63D4.8040807@mvista.com> <1049433965.1165.2.camel@hawk.sh.intel.com>
	 <3E8D9CD2.8060506@acm.org>
Content-Type: text/plain
Organization: Intel Crop.
Message-Id: <1049678799.1165.24.camel@hawk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 07 Apr 2003 09:26:40 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-04 at 22:55, Corey Minyard wrote:
> I've merged this in, but I made some adjustments:
> 
>     * I added a copyright to include/net/ipmi.h (just copied from
> net/ipmi/af_ipmi.c)
Just curious, should we add copyright even when I have announced it by
'MODULE_LICENSE("GPL")'? I dislike too many leagal text in code...
>     * I added usage comments to include/net/ipmi.h
>     * I modified the ioctls to return EFAULT on a bad user address.
>     * I modified SIOCIPMIGETEVENT to take a pointer to an integer, not
> an integer.  That's the way ioctls work, they always take a pointer,
> even though it sucks, IMHO.
> 
> I also adapted it to the 2.4 kernel.
> 
> I'll put out an experimental patch for this sometime soon (with a bunch
> of other stuff).  I also have SMIC and full ACPI support as part of it,
> and I'm waiting for them.
> 
> - -Corey

-- 
Yours truly,
Louis Zhuang
---------------
My words are my own...

Fault Injection Test Harness Project
BK tree: http://fault-injection.bkbits.net/linux-2.5
Home Page: http://sf.net/projects/fault-injection

Open HPI Project
Home Page: http://sf.net/projects/openhpi

