Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWHCXkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWHCXkz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 19:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWHCXkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 19:40:55 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:28837 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751376AbWHCXky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 19:40:54 -0400
Message-ID: <44D28985.8050200@vmware.com>
Date: Thu, 03 Aug 2006 16:40:53 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>	 <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>	 <44D26D87.2070208@vmware.com>	 <1154644383.23655.142.camel@localhost.localdomain>  <44D2794A.0@vmware.com> <1154647835.23655.161.camel@localhost.localdomain>
In-Reply-To: <1154647835.23655.161.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Iau, 2006-08-03 am 15:31 -0700, ysgrifennodd Zachary Amsden:
>   
>> Alan Cox wrote:
>>     
>>> Could have fooled me. It seems to work for the IBM Mainframe people
>>> really well. 
>>>       
>> Yes, but not because of source compatibility.  It works because the 
>> hypervisor layer is actually architected in the hardware.
>>     
>
> The hardware has nothing to do with it. It works because the hypervisor
> API has a spec and is maintained compatibly. Its not entirely hardware
> architected either, it has chunks of interfaces that are not present
> hardware level or not meaningful at that level - the paging assists for
> example are purely a hypervisor interface as are hipersockets.
>   

Yes, it's part hardware, part software, a pseudo firmwarish mesh of the 
two.  When you've got multiple vendors involved, you need to paint the 
interface with a broader stroke so that the individual details of each 
don't get so involved, and you can do that in many different ways.  You 
still need an ABI, not just an API, though, for future compatibility of 
existing kernels, which is important to mainframe customers for 
migration as well as virtual machine users.

But I think we're running off into the weeds picking nits here..

Zach
