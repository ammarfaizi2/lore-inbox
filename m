Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbUL3CEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbUL3CEw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 21:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbUL3CEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 21:04:52 -0500
Received: from mail.tmr.com ([216.238.38.203]:50374 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261506AbUL3CEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 21:04:50 -0500
Message-ID: <41D3646A.9020806@tmr.com>
Date: Wed, 29 Dec 2004 21:14:02 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fryderyk Mazurek <dedyk@go2.pl>
CC: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Problems with 2.6.10
References: <1104201851.18175.39.camel@d845pe><20041227171159.51454193BFA@r10.go2.pl> <20041228145600.6A9FC193D36@r10.go2.pl>
In-Reply-To: <20041228145600.6A9FC193D36@r10.go2.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fryderyk Mazurek wrote:
> Hello.
> 
> My kernel 2.6.10 I compiled two times. First with ACPI and second
> fully without ACPI. And the same situation.
> For me this situation is strange, because usually reset should help,
> but not this time. I thought that maybe my BIOS is too old. But with
> 2.6.9 works. Therefore I don't know. Now I use 2.6.9.
> 
> Fryderyk.
> 
> ---- Wiadomo¶æ Oryginalna ----
> Od: Len Brown <len.brown@intel.com>
> Do: Fryderyk Mazurek <dedyk@go2.pl>
> Kopia do: linux-kernel@vger.kernel.org
> Data: 27 Dec 2004 21:44:11 -0500
> Temat: Re: Problems with 2.6.10
> 
> 
>>On Mon, 2004-12-27 at 12:11, Fryderyk Mazurek wrote:
>>
>>
>>>problem starts when I do reboot. On boot screen my bios can't detect
>>>my disk. Bios stops and nothing.
>>
>>Does reboot work if the initial boot is with acpi=off?

With that system, perhaps acpi=ht would be better if he uses the HT. And 
pci=routeirq may help as well, although it told me it was disabling 
IRQ18 and didn't!

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
