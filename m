Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbWGEVkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWGEVkY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 17:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbWGEVkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 17:40:23 -0400
Received: from terminus.zytor.com ([192.83.249.54]:7879 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964952AbWGEVkX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 17:40:23 -0400
Message-ID: <44AC318A.5050303@zytor.com>
Date: Wed, 05 Jul 2006 14:39:22 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Dave Jones <davej@redhat.com>, Matthew Wilcox <matthew@wil.cx>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Limit VIA and SIS AGP choices to x86
References: <20060705175725.GL1605@parisc-linux.org>	 <20060705192147.GF1877@redhat.com> <1152127676.3201.62.camel@laptopd505.fenrus.org>
In-Reply-To: <1152127676.3201.62.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Wed, 2006-07-05 at 15:21 -0400, Dave Jones wrote:
>> On Wed, Jul 05, 2006 at 11:57:25AM -0600, Matthew Wilcox wrote:
>>  > 
>>  > As far as I am aware, Alpha, PPC and IA64 don't have VIA or SIS AGP
>>  > chipsets available.
>>
>> VIA has turned up on PPC (some Apple notebooks).
> 
> only the southbridge... agp is a northbridge thing...
> 

Not necessarily.  Some HyperTransport southbridges have AGP on them, for 
example.

	-hpa
