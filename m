Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWHBCmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWHBCmf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 22:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWHBCmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 22:42:35 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15297 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751080AbWHBCme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 22:42:34 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: vgoyal@in.ibm.com
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Linda Wang <lwang@redhat.com>
Subject: Re: [RFC] ELF Relocatable x86 and x86_64 bzImages
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<20060801204023.GG7054@in.ibm.com>
Date: Tue, 01 Aug 2006 20:40:58 -0600
In-Reply-To: <20060801204023.GG7054@in.ibm.com> (Vivek Goyal's message of
	"Tue, 1 Aug 2006 16:40:23 -0400")
Message-ID: <m1irlbx3k5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Tue, Aug 01, 2006 at 04:58:49AM -0600, Eric W. Biederman wrote:
>> 
>> Currently there are 33 patches in my tree to do this.
>> 
>> The weirdest symptom I have had so far is that page faults did not
>> trigger the early exception handler on x86_64 (instead I got a reboot).
>> 
>> There is one outstanding issue where I am probably requiring too much
> alignment
>> on the arch/i386 kernel.  
>> 
>> Can anyone find anything else?
>>
>
> I am running into compilation failure on x86_64.

I'm not quite certain what is wrong, except that you haven't
applied all of my patches.

The x86_64 ones do depend on the i386 ones to some extent.
That is why it was one giant patchset.

Eric
