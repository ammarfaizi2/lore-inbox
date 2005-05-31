Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVEaLln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVEaLln (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 07:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbVEaLln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 07:41:43 -0400
Received: from fmr18.intel.com ([134.134.136.17]:37261 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261872AbVEaLll convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 07:41:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH]CPU hotplug breaks wake_up_new_task
Date: Tue, 31 May 2005 19:41:22 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575021F0F33@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]CPU hotplug breaks wake_up_new_task
Thread-Index: AcVlzoKxlqG4j48uRtaB6Ku/I4bSCgABog1w
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>, <vatsa@in.ibm.com>
Cc: "lkml" <linux-kernel@vger.kernel.org>, "akpm" <akpm@osdl.org>,
       "Ingo Molnar" <mingo@elte.hu>, "Rusty Russell" <rusty@rustcorp.com.au>,
       "Raj, Ashok" <ashok.raj@intel.com>
X-OriginalArrivalTime: 31 May 2005 11:41:24.0463 (UTC) FILETIME=[AC646FF0:01C565D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Srivatsa Vaddagiri wrote:
>> On Tue, May 31, 2005 at 07:46:13PM +1000, Nick Piggin wrote:
>>
>>>And this patch will break balance-on-fork.
>>
>>
>> Right :-)
>>
>>
>>>How about conditionally setting task_cpu if the task's current
>>>CPU is offline?
>>
>>
>> Something like this?
>>
>
>That's exactly what I had in mind ;)
>Shaohua, do you agree?
That's better. Thanks!

Cheers,
Shaohua
