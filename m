Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVFPQpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVFPQpm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 12:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVFPQpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 12:45:42 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:41460 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261767AbVFPQpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 12:45:34 -0400
Message-ID: <42B1ACA6.7020105@google.com>
Date: Thu, 16 Jun 2005 09:45:26 -0700
From: Hareesh Nagarajan <hareesh@google.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Porting kref to a 2.4 kernel (2.4.20 or greater)
References: <42B06344.4040909@google.com> <20050615220734.GC620@kroah.com> <42B0B017.60001@google.com> <20050616091853.GA4965@in.ibm.com>
In-Reply-To: <20050616091853.GA4965@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:
> On Wed, Jun 15, 2005 at 03:47:51PM -0700, Hareesh Nagarajan wrote:
> 
>>Correction:
>>(Appears with a *)
>>
>>Greg KH wrote:
>>
>>>On Wed, Jun 15, 2005 at 10:20:04AM -0700, Hareesh Nagarajan wrote:
>>>
>>>
>>>>What stumbling blocks do you think I would encounter if I wanted to port 
>>>>kref to a 2.4.xx kernel? Is kref tightly coupled with the kernel object 
>>>>infrastructure found in the 2.6.xx kernel?
>>>
>>>Have you looked at the kref code to see if there is any such coupling?
>>
>>>Can you describe any problems you are having doing the uncoupling?
>>
>>I'm having problems porting the KObject* and Work Queue infrastructure 
>>to the 2.4 kernel. Any ideas if anyone has tried this port?
>>
>>(Correction: * => I meant KThread)
> 
> 
> There were a number of backports of 2.6 workqueue stuff without
> kthread (before they were introduced for cpu hotplug) floating
> around in mailing list. You can probably google for them.

I will do that!

> Aren't they sufficient or does google want to do CPU hotplug ? :)

I was thinking of porting the RelayFS patches (from 2.6.11-mm2) to the 
2.4 kernel. RelayFS seems to use the work queue infrastructure.

And AFAIK, Google doesn't seem to be too interested in hotplugging :)

Thanks Dipankar!

Hareesh
