Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWC1RF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWC1RF2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 12:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWC1RF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 12:05:27 -0500
Received: from mail.tektonic.net ([207.210.74.214]:34739 "HELO unix.easyadmin")
	by vger.kernel.org with SMTP id S1751138AbWC1RF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 12:05:27 -0500
Message-ID: <44296CB2.9090909@tektonic.net>
Date: Tue, 28 Mar 2006 12:04:50 -0500
From: Matt Ayres <matta@tektonic.net>
Organization: TekTonic
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: devel@openvz.org, Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, sam@vilain.net,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, serue@us.ibm.com,
       "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au>	<4428FB90.5000601@sw.ru> <44295AE8.7010200@tektonic.net> <m1r74mbjwe.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1r74mbjwe.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Eric W. Biederman wrote:
> Matt Ayres <matta@tektonic.net> writes:
> 
>> I think the Xen guys would disagree with you on this.  Xen claims <3% overhead
>> on the XenSource site.
>>
>> Where did you get these figures from?  What Xen version did you test? What was
>> your configuration? Did you have kernel debugging enabled? You can't just post
>> numbers without the data to back it up, especially when it conflicts greatly
>> with the Xen developers statements.  AFAIK Xen is well on it's way to inclusion
>> into the mainstream kernel.
> 
> It doesn't matter.  The proof that Xen has more overhead is trivial
> Xen does more, and Xen clients don't share resources well.
> 

I understand the difference. It was more about Kirill grabbing numbers 
out of the air.  I actually think the containers and Xen complement each 
other very well.  As Xen is now based on 2.6.16 (as are both VServer and 
OVZ) it makes sense to run a few Xen domains that then in turn run 
containers in some scenarios.  As far as the last part, Xen doesn't 
share resources at all :)

Thank you,
Matt Ayres
