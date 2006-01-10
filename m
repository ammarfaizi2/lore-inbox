Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWAJV2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWAJV2m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 16:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWAJV2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 16:28:42 -0500
Received: from dvhart.com ([64.146.134.43]:12929 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932336AbWAJV2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 16:28:41 -0500
Message-ID: <43C42708.4020108@mbligh.org>
Date: Tue, 10 Jan 2006 13:28:40 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Although CONFIG_IRQBALANCE is enabled IRQ's don't seem to be
 balanced very well
References: <9a8748490601100314u26d4a566uc41a1912e410ea46@mail.gmail.com> <20060110203115.GB5479@filer.fsl.cs.sunysb.edu>
In-Reply-To: <20060110203115.GB5479@filer.fsl.cs.sunysb.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josef Sipek wrote:
> On Tue, Jan 10, 2006 at 12:14:42PM +0100, Jesper Juhl wrote:
> 
>>Do I need any userspace tools in addition to CONFIG_IRQBALANCE?
> 
> 
> Last I checked, yes you do need "irqbalance" (at least that's what
> the package is called in debian.

Nope - you need the kernel option turned on OR the userspace daemon,
not both.

If you're not generating interrupts at a high enough rate, it won't
rotate. That's deliberate.

M.
