Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWC1Pta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWC1Pta (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 10:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWC1Pta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 10:49:30 -0500
Received: from mail.tektonic.net ([207.210.74.214]:52393 "HELO unix.easyadmin")
	by vger.kernel.org with SMTP id S1751164AbWC1Pt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 10:49:29 -0500
Message-ID: <44295AE8.7010200@tektonic.net>
Date: Tue, 28 Mar 2006 10:48:56 -0500
From: Matt Ayres <matta@tektonic.net>
Organization: TekTonic
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: devel@openvz.org
CC: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, sam@vilain.net,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, serue@us.ibm.com,
       "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
Subject: Re: [Devel] Re: [RFC] Virtualization steps 
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au> <4428FB90.5000601@sw.ru>
In-Reply-To: <4428FB90.5000601@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Kirill Korotaev wrote:
>> Oh, after you come to an agreement and start posting patches, can you
>> also outline why we want this in the kernel (what it does that low
>> level virtualization doesn't, etc, etc), and how and why you've agreed
>> to implement it. Basically, some background and a summary of your
>> discussions for those who can't follow everything. Or is that a faq
>> item?
> Nick, will be glad to shed some light on it.
> 
> First of all, what it does which low level virtualization can't:
> - it allows to run 100 containers on 1GB RAM
>   (it is called containers, VE - Virtual Environments,
>    VPS - Virtual Private Servers).
> - it has no much overhead (<1-2%), which is unavoidable with hardware
>   virtualization. For example, Xen has >20% overhead on disk I/O.

I think the Xen guys would disagree with you on this.  Xen claims <3% 
overhead on the XenSource site.

Where did you get these figures from?  What Xen version did you test? 
What was your configuration? Did you have kernel debugging enabled? You 
can't just post numbers without the data to back it up, especially when 
it conflicts greatly with the Xen developers statements.  AFAIK Xen is 
well on it's way to inclusion into the mainstream kernel.

Thank you,
Matt Ayres
