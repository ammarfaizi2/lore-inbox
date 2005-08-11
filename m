Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbVHKFop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbVHKFop (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 01:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVHKFop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 01:44:45 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:22402 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S932241AbVHKFoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 01:44:44 -0400
X-Envelope-From: hpa@zytor.com
Message-ID: <42FAE59F.8070009@zytor.com>
Date: Wed, 10 Aug 2005 22:43:59 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Zwane Mwaikambo <zwane@arm.linux.org.uk>, zach@vmware.com, akpm@osdl.org,
       chrisl@vmware.com, Keir.Fraser@cl.cam.ac.uk,
       linux-kernel@vger.kernel.org, m+Ian.Pratt@cl.cam.ac.uk,
       mbligh@mbligh.org, pratap@vmware.com, virtualization@lists.osdl.org
Subject: Re: [PATCH 8/14] i386 / Add a per cpu gdt accessor
References: <200508110456.j7B4ue56019587@zach-dev.vmware.com> <Pine.LNX.4.61.0508102344060.16483@montezuma.fsmlabs.com> <20050811054045.GU7762@shell0.pdx.osdl.net>
In-Reply-To: <20050811054045.GU7762@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Zwane Mwaikambo (zwane@arm.linux.org.uk) wrote:
> 
>>On Wed, 10 Aug 2005 zach@vmware.com wrote:
>>
>>
>>>Add an accessor function for getting the per-CPU gdt.  Callee must already
>>>have the CPU.
>>
>>This one seems superfluous to me, does accessing it indirectly generate 
>>better code too?
> 
> 
> It's prepratory for other work.
> 

I am assuming it has no change on the code, right?  (If it does, 
something is wrong...)

	-hpa
