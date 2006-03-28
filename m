Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWC1E2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWC1E2q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 23:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWC1E2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 23:28:46 -0500
Received: from mail.tmr.com ([64.65.253.246]:24985 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S1751163AbWC1E2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 23:28:45 -0500
Message-ID: <4428BB5C.3060803@tmr.com>
Date: Mon, 27 Mar 2006 23:28:12 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Kirill Korotaev <dev@sw.ru>, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       serue@us.ibm.com, akpm@osdl.org, sam@vilain.net,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pavel Emelianov <xemul@sw.ru>,
       Stanislav Protassov <st@sw.ru>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru>  <44242D4D.40702@yahoo.com.au> <1143228339.19152.91.camel@localhost.localdomain>
In-Reply-To: <1143228339.19152.91.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Sat, 2006-03-25 at 04:33 +1100, Nick Piggin wrote:
>> Oh, after you come to an agreement and start posting patches, can you
>> also outline why we want this in the kernel (what it does that low
>> level virtualization doesn't, etc, etc) 
> 
> Can you wait for an OLS paper? ;)
> 
> I'll summarize it this way: low-level virtualization uses resource
> inefficiently.
> 
> With this higher-level stuff, you get to share all of the Linux caching,
> and can do things like sharing libraries pretty naturally.
> 
> They are also much lighter-weight to create and destroy than full
> virtual machines.  We were planning on doing some performance
> comparisons versus some hypervisors like Xen and the ppc64 one to show
> scaling with the number of virtualized instances.  Creating 100 of these
> Linux containers is as easy as a couple of shell scripts, but we still
> can't find anybody crazy enough to go create 100 Xen VMs.

But these require a modified O/S, do they not? Or do I read that 
incorrectly? Is this going to be real virtualization able to run any O/S?

Frankly I don't see running 100 VMs as a realistic goal, being able to 
run Linux, Windows, Solaris and BEOS unmodified in 4-5 VMs would be far 
more useful.
> 
> Anyway, those are the things that came to my mind first.  I'm sure the
> others involved have their own motivations.
> 
> -- Dave
> 

