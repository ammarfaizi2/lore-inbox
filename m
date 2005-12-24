Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbVLXQSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVLXQSM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 11:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbVLXQSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 11:18:12 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:32362 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932123AbVLXQSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 11:18:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=WfXo0fVZx7rEwIa091C3LROj5hqNqMSBBA+5UDDHSuHZlQN2oMF4Knu420BnUSsJi4XNWiaMWB8/dtQpzENY3jCnV+6/cCqzOrzt06pBaiHDiKr1Fray23ymME7L/obyJ++VcPRJ4Riiwt9ux0VnfOnh8toTcq7jtjdHK4uVYN8=
Message-ID: <43AD744D.8010404@gmail.com>
Date: Sat, 24 Dec 2005 18:16:13 +0200
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: Lee Revell <rlrevell@joe-job.com>, David Wagner <daw@cs.berkeley.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Question] LinuxThreads, setuid - Is there user mode hook?
References: <200512222312.jBMNCj96018554@taverner.CS.Berkeley.EDU> <43ABC8B2.7020904@gmail.com> <1135364939.22177.15.camel@mindpipe> <20051223202105.GA32321@nevyn.them.org> <1135370197.22177.40.camel@mindpipe> <20051223203347.GA32589@nevyn.them.org>
In-Reply-To: <20051223203347.GA32589@nevyn.them.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz wrote:
> On Fri, Dec 23, 2005 at 03:36:37PM -0500, Lee Revell wrote:
> 
>>On Fri, 2005-12-23 at 15:21 -0500, Daniel Jacobowitz wrote:
>>
>>>On Fri, Dec 23, 2005 at 02:08:58PM -0500, Lee Revell wrote:
>>>
>>>>Why on earth would you use LinuxThreads rather than NPTL?  LinuxThreads
>>>>is obsolete and was never remotely POSIX compliant.
>>>
>>>You have the strangest ideas of obsolete.  NPTL has only been usable
>>>for two years.  Software lifecycles can be a lot longer than that.
>>>
>>
>>I'm not telling you to stop supporting legacy apps, I'm just saying it's
>>insane to start a project now and target LinuxThreads rather than NPTL
>>which is what it sounded like the OP was doing.
> 
> 
> Applications have to run on existing platforms and work with existing
> software, as I'm sure you know.  If someone anywhere in the food chain
> isn't ready for NPTL, a project can easily be stuck with LT for another
> few years.
> 

Thank you for your comments!

Unfortunately I cannot force the users to move into NPTL... 
So I thought I will create some kind of a workaround...

So back to my original question... Can I be notified if the 
main setuid?

My other solution is to poll the pid of the main program for 
this event.

Best Regards,
Alon Bar-Lev.
