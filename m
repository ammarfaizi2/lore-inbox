Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751575AbWHJU2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbWHJU2f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbWHJU2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:28:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27572 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750781AbWHJU2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 16:28:09 -0400
Message-ID: <44DB965A.3050208@redhat.com>
Date: Thu, 10 Aug 2006 16:26:02 -0400
From: Prarit Bhargava <prarit@redhat.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Yasunori Goto <y-goto@jp.fujitsu.com>
CC: akpm@osdl.org, "Brown, Len" <len.brown@intel.com>,
       keith mannthey <kmannth@us.ibm.com>,
       ACPI-ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
Subject: Re: [PATCH](memory hotplug) Repost remove useless message at boot
 time from 2.6.18-rc4.
References: <20060804213230.D5D4.Y-GOTO@jp.fujitsu.com> <20060810142329.EB03.Y-GOTO@jp.fujitsu.com>
In-Reply-To: <20060810142329.EB03.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Yasunori Goto wrote:
> Hello.
>
> I would like to repost this patch to remove noisy useless message at boot
> time from 2.6.18-rc4.
> (I said "-mm doesn't shows this message in previous post", but it was wrong.
>  This messages are shown by -mm too.)
>
> -------------------------
> This is to remove noisy useless message at boot time from 2.6.18-rc4.
> The message is a ton of
> "ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device"
>
>   
I'm seeing this on some of my ia64 boxes, however, I see

ACPI Exception (acpi_memory-0491): AE_ERROR, handle is no memory device 
[20060707]

What's interesting is that last little bit looks an awful lot like a 
date.... It's almost as if we were
reading beyond the end of the ACPI table?

Still investigating,

P.
