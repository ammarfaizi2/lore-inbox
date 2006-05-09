Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWEIPMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWEIPMl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 11:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWEIPMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 11:12:41 -0400
Received: from dvhart.com ([64.146.134.43]:8419 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751157AbWEIPMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 11:12:40 -0400
Message-ID: <4460B161.7030800@mbligh.org>
Date: Tue, 09 May 2006 08:12:33 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com
Subject: Re: [RFC PATCH 00/35] Xen i386 paravirtualization support
References: <20060509084945.373541000@sous-sol.org> <4460AC01.5020503@mbligh.org> <20060509150701.GA14050@infradead.org>
In-Reply-To: <20060509150701.GA14050@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Tue, May 09, 2006 at 07:49:37AM -0700, Martin J. Bligh wrote:
> 
>>Congrats on getting this thrashed out. A few comments, most of which are
>>boring style nits, but nonetheless ... will try to take a proper look
>>later.
>>
>>General comment:
>>
>>Why is this style used:
>>
>>HYPERVISOR_foo_bar ?
>>
>>ie the capitalization of HYPERVISOR. Doesn't seem to fit with the rest
>>of the kernel style.
> 
> 
> It's also wrong.  There's more than one hypervisor and Xen shouldn't just
> grab this namespace.  make it xen_ or xenhv_.

I think the intent was to create something generic enough for others to
use. There were other projects that already intended to use the same
model ... and please, lets not have one stack of this stuff for each
hypervisor. So in general, I think the approach is correct, I was just
whining about style stuff ;-)

M.
