Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131573AbRC3Rbj>; Fri, 30 Mar 2001 12:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131578AbRC3Rb3>; Fri, 30 Mar 2001 12:31:29 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:19907 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S131573AbRC3RbS>; Fri, 30 Mar 2001 12:31:18 -0500
Message-ID: <3AC4C26E.7050406@muppetlabs.com>
Date: Fri, 30 Mar 2001 09:29:18 -0800
From: Amit D Chaudhary <amit@muppetlabs.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory leak in the ramfs file system
In-Reply-To: <Pine.LNX.3.96.1010330034506.8826F-100000@mandrakesoft.mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the reply.

So the question next would be whether ramfs will include features to make it 
viable or stay with less features with the aim of keeping it simple.

Today, plan to check the 2-4.2-ac2x series to see if they fix this.

Regards
Amit

Jeff Garzik wrote:

> On Thu, 29 Mar 2001, Amit D Chaudhary wrote:
> 
>>  >(none):/mnt/ramfs/root# df -h /mnt/ramfs/
>>  >Filesystem            Size  Used Avail Use% Mounted on
>>  >ramfs                    0     0     0   -  /mnt/ramfs
>> I am not sure, how related this is, but we have / on ramfs and using rpm 
>> to install(-iUvh) fails with the mesages, need 12K on /
> 
> 
> This is normal -- ramfs doesn't do filesystem accounting needed for 'df'.

