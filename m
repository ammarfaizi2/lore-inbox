Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263254AbUCTJBr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 04:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263256AbUCTJBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 04:01:47 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:30875 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263254AbUCTJBq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 04:01:46 -0500
Message-ID: <405C0873.6080805@cyberone.com.au>
Date: Sat, 20 Mar 2004 20:01:39 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: Mark Wong <markw@osdl.org>, Andrew Morton <akpm@osdl.org>, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm2
References: <A6974D8E5F98D511BB910002A50A6647615F5E2B@hdsmsx402.hd.intel.com> <1079756877.7277.644.camel@dhcppc4>
In-Reply-To: <1079756877.7277.644.camel@dhcppc4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Len Brown wrote:

>On Fri, 2004-03-19 at 23:19, Brown, Len wrote:
>
>>CONFIG_X86_HT=y does not enable HT.
>>CONFIG_X86_HT=n does not disable HT.
>>It only controls if the cpu_sibling_map[] etc. are initialized.
>>
>>acpi=off does not disable HT
>>
>
>oops, that line incorrect.
>we fixed "acpi=off" to _really_ mean ACPI off -- table parsing
>and all, so it does disable HT, along w/ all the other stuff
>that depends on ACPI.
>
>

So how come oprofile seems to think there is a sibling?
Can you verify both cases use physical only CPUs?

