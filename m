Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313242AbSEESAY>; Sun, 5 May 2002 14:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313254AbSEESAX>; Sun, 5 May 2002 14:00:23 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:6366 "EHLO mail3.aracnet.com")
	by vger.kernel.org with ESMTP id <S313242AbSEESAX>;
	Sun, 5 May 2002 14:00:23 -0400
Date: Sun, 05 May 2002 10:59:03 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: vda@port.imtp.ilyichevsk.odessa.ua
cc: linux-kernel@vger.kernel.org
Subject: Re: Virtual address space exhaustion (was Discontigmem virt_to_page() )
Message-ID: <4237780085.1020596342@[10.10.2.3]>
In-Reply-To: <200205041944.g44JiEX12535@Port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 3 May 2002 20:35, Martin J. Bligh wrote:
>> > No. It's not stupid. Unix defines a kind of operating system that
>> > has certain characteristics and/or attributes. Process/kernel shared
>> > address space is one of them. It's a name that has historical
>> > signifigance.
>> 
>> Yes it is stupid. This is a small implementation detail, and has no
>> real importance whatsoever. People have done this in the past
>> (Dynix/PTX did it) will do so in the future. Nor does the kernel
>> address space have to be global and shared across all tasks
>> as stated earlier in this thread. What makes it Unix is the interface
>> it presents to the world, and how it behaves, not the little details
>> of how it's implemented inside.
> 
> I'm curious where it is visible to userspace?
> (I'm asking for educational purposes)

Where what is visible to userspace? If you mean the bit about 
"the interface it presents to the world", I meant Linux in 
general, not this feature. The whole point is that this is 
invisble to userspace (apart from performance and a lack of
architectural restrictions you might have been expecting) 
therefore it's irrelevant to whether it's "Unix" like or not.

M.

