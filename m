Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752324AbWKBAyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbWKBAyE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 19:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752375AbWKBAyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 19:54:04 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:58828 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1752324AbWKBAyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 19:54:02 -0500
Message-ID: <454941A8.6000601@vmware.com>
Date: Wed, 01 Nov 2006 16:54:00 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] paravirtualization: Patch inline replacements for
 common paravirt operations.
References: <20061029024504.760769000@sous-sol.org>	 <20061029024607.401333000@sous-sol.org> <200610290831.21062.ak@suse.de>	 <1162178936.9802.34.camel@localhost.localdomain>	 <20061030231132.GA98768@muc.de>	 <1162376827.23462.5.camel@localhost.localdomain>	 <1162376894.23462.7.camel@localhost.localdomain>	 <20061101152715.f1f94d5c.akpm@osdl.org> <1162428424.6848.14.camel@localhost.localdomain>
In-Reply-To: <1162428424.6848.14.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> On Wed, 2006-11-01 at 15:27 -0800, Andrew Morton wrote:
>   
>> On Wed, 01 Nov 2006 21:28:13 +1100
>> Rusty Russell <rusty@rustcorp.com.au> wrote:
>>     
>>> +#ifdef CONFIG_DEBUG_KERNEL
>>> +		/* Deliberately clobber regs using "not %reg" to find bugs. */
>>>       
>> That would be considered to be abusive of CONFIG_DEBUG_KERNEL.  A
>> CONFIG_DEBUG_PARAVIRT which depends on CONFIG_DEBUG_KERNEL would be more
>> harmonious.
>>     
>
> I wasn't sure.  Making a config option for what is a one-liner seemed
> overkill.
>   

I have further stuff in my vmi-debug patch that can use 
CONFIG_DEBUG_PARAVIRT as well :)

Zach
