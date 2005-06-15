Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVFOWiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVFOWiY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 18:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVFOWiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 18:38:24 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:6846 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261597AbVFOWiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 18:38:20 -0400
Message-ID: <42B0ADD5.3080502@google.com>
Date: Wed, 15 Jun 2005 15:38:13 -0700
From: Hareesh Nagarajan <hareesh@google.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Porting kref to a 2.4 kernel (2.4.20 or greater)
References: <42B06344.4040909@google.com> <20050615220734.GC620@kroah.com>
In-Reply-To: <20050615220734.GC620@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Jun 15, 2005 at 10:20:04AM -0700, Hareesh Nagarajan wrote:
> 
>>What stumbling blocks do you think I would encounter if I wanted to port 
>>kref to a 2.4.xx kernel? Is kref tightly coupled with the kernel object 
>>infrastructure found in the 2.6.xx kernel?
> 
> Have you looked at the kref code to see if there is any such coupling?

Not really. Kref seems pretty light and loosely coupled with the 2.6 
kernel. There just appears to be a C file (and a .h of course).

> Can you describe any problems you are having doing the uncoupling?

I'm having problems porting the KObject and Work Queue infrastructure to 
the 2.4 kernel. Any ideas if anyone has tried this port?

> What do you want this in the 2.4 kernel for?  

I need to port RelayFS into a 2.4 kernel.

> You know that no new
> features are being accepted for that tree, right?

Yes, I am aware of that :(

Thank you very much!

Hareesh
-= Engineering Intern =-
cs.uic.edu/~hnagaraj
