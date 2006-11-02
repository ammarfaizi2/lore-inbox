Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752756AbWKBJX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbWKBJX3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 04:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752761AbWKBJX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 04:23:29 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:43530 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1752756AbWKBJX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 04:23:28 -0500
Message-ID: <4549B8CA.7010502@shadowen.org>
Date: Thu, 02 Nov 2006 09:22:18 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@google.com>,
       Cornelia Huck <cornelia.huck@de.ibm.com>,
       Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
       Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
References: <20061031182919.3a15b25a@gondolin.boeblingen.de.ibm.com> <4547FABE.502@google.com> <20061101020850.GA13070@suse.de> <45480241.2090803@google.com> <20061102052409.GA9642@suse.de> <45498174.5070309@google.com> <20061102060225.GA11188@suse.de> <20061101220701.78a1fa88.akpm@osdl.org> <20061102064227.GA11693@suse.de> <20061101224915.19d1b1ac.akpm@osdl.org> <20061102065609.GA14353@suse.de>
In-Reply-To: <20061102065609.GA14353@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Nov 01, 2006 at 10:49:15PM -0800, Andrew Morton wrote:
>> On Wed, 1 Nov 2006 22:42:27 -0800
>> Greg KH <gregkh@suse.de> wrote:
>>
>>> On Wed, Nov 01, 2006 at 10:07:01PM -0800, Andrew Morton wrote:
>>>> On Wed, 1 Nov 2006 22:02:25 -0800
>>>> Greg KH <gregkh@suse.de> wrote:
>>>>
>>>>>> Thanks for fixing this up. If you could post a diff somewhere against
>>>>>> either mainline or -mm, would make it easy to run through
>>>>>> test.kernel.org before you wake up tommorow ;-)
>>>>> Oops, the newest -mm just came out without any of the driver core
>>>>> patches in it due to the problems.  I'll wait until the next -mm release
>>>>> then, and try to go catch up on my pending-patch-queue right now
>>>>> instead...
>>>> Let me know when
>>>> http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-01-driver/
>>>> is ready to go and I'll prepare a new rollup.
>>> It should be ready to go right now.  Fire away :)
>>>
>> Poor Cornelia.  All her patches broke again.
> 
> Yeah, I knew that would happen.  I have them still in my queue, I'll
> handle porting them to my tree now, I've forced her to handle my
> mistakes too much already :)
> 
> So you can drop them now, I'll get to them tomorrow.
> 
> Let's verify that this all is fixed first :)

If you can trivially produce a single patch against 2.6.19-rc3-mm1 or
2.6.19-rc4-mm1 (or any other tree :)) I can shove it through TKO and see
what comes out; and I'd say its worth it.

-apw
