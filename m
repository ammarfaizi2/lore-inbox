Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWHCT0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWHCT0S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 15:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWHCT0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 15:26:18 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:39051 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932466AbWHCT0R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 15:26:17 -0400
Message-ID: <44D24DD8.1080006@vmware.com>
Date: Thu, 03 Aug 2006 12:26:16 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>
In-Reply-To: <20060803190605.GB14237@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Aug 03, 2006 at 03:14:21AM -0700, Zachary Amsden wrote:
>   
>> I would like to propose an interface for linking a GPL kernel, 
>> specifically, Linux, against binary blobs.
>>     
>
> Sorry, but we aren't lawyers here, we are programmers.  Do you have a
> patch that shows what you are trying to describe here?  Care to post it?
>   

<Posts kernel/module.c unmodified>

> How does this differ with the way that the Xen developers are proposing?
> Why haven't you worked with them to find a solution that everyone likes?
>   

We want our backend to provide a greater degree of stability than a pure 
source level API as the Xen folks have proposed.  We have tried to 
convince them that an ABI is in their best interest, but they are 
reluctant to commit to one or codesign one at this time.

> And what about Rusty's proposal that is supposed to be the "middle
> ground" between the two competing camps?  How does this differ from
> that?  Why don't you like Rusty's proposal?
>   

Who said that?  Please smack them on the head with a broom.  We are all 
actively working on implementing Rusty's paravirt-ops proposal.  It 
makes the API vs ABI discussion moot, as it allow for both.

> Please, start posting code and work together with the other people that
> are wanting to achive the same end goal as you are.  That is what really
> matters here.
>   

We have already started upstreaming patches.  Jeremy, Rusty and I have 
or will send out sets yesterday / today.  We haven't been vocal on LKML, 
as we'd just be adding noise.  We are working with Rusty and the Xen 
developers, and you can see our patchset here:

http://ozlabs.org/~rusty/paravirt/?cl=tip

And follow our development discussions here:

http://lists.osdl.org/pipermail/virtualization/

Zach
