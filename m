Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266565AbUGPTZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266565AbUGPTZM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 15:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266567AbUGPTZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 15:25:12 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:26718 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266565AbUGPTZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 15:25:05 -0400
Message-ID: <40F829B0.70000@sbcglobal.net>
Date: Fri, 16 Jul 2004 14:17:04 -0500
From: "Robert W. Fuller" <kombi@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040601
X-Accept-Language: en
MIME-Version: 1.0
To: "Li, Shaohua" <shaohua.li@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ACPI hang on Compaq 2199US laptop with kernel 2.6.7
References: <B44D37711ED29844BEA67908EAF36F03568506@pdsmsx401.ccr.corp.intel.com>
In-Reply-To: <B44D37711ED29844BEA67908EAF36F03568506@pdsmsx401.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That solved the problem!  The laptop boots with ACPI as long as I 
specify the "nolapic" option.

Is this an RTFM?  If so, where is the manual?

Li, Shaohua wrote:
> Please try 'nolapic' boot option. -Shaohua
> 
> 
>>-----Original Message-----
>>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>>owner@vger.kernel.org] On Behalf Of Robert W. Fuller
>>Sent: Wednesday, July 14, 2004 11:58 PM
>>To: linux-kernel@vger.kernel.org
>>Subject: Re: ACPI hang on Compaq 2199US laptop with kernel 2.6.7
>>
>>Hmm.  No reply.  Am I not asking for help in the right place?
>>
>>Robert W. Fuller wrote:
>>
>>>If I have ACPI configured for the 2.6.7 kernel, boot hangs after the
>>>message "ACPI: IRQ9 SCI: Level Trigger."  If I configure the 2.6.7
>>>kernel without ACPI, everything is fine.
>>>
>>>I would like to have ACPI because my laptop does not have APM.  The
>>>laptop model is a Compaq Presario 2199US.
>>>-
>>>To unsubscribe from this list: send the line "unsubscribe
> 
> linux-kernel"
> 
>>in
>>
>>>the body of a message to majordomo@vger.kernel.org
>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> 
> in
> 
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 
