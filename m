Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbSLRAUS>; Tue, 17 Dec 2002 19:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267042AbSLRAUS>; Tue, 17 Dec 2002 19:20:18 -0500
Received: from cynosure.colorado-research.com ([65.171.192.72]:65156 "EHLO
	cynosure.colorado-research.com") by vger.kernel.org with ESMTP
	id <S265446AbSLRAUR>; Tue, 17 Dec 2002 19:20:17 -0500
Message-ID: <3DFFC119.2070401@cora.nwra.com>
Date: Tue, 17 Dec 2002 17:28:09 -0700
From: Orion Poplawski <orion@cora.nwra.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Samuel Flory <sflory@rackable.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: NFS - IRIX client issues
References: <3DEE85D3.6070009@cora.nwra.com> <3DEE8EC2.2040305@rackable.com> <3DEE9425.40204@cora.nwra.com> <3DEE95D0.9010706@rackable.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Flory wrote:

> Orion Poplawski wrote:
>
>>>
>> The mount comes up fine and works for quite a while and then crashes. 
>> This is under relatively heavy load (tar files being unpacked, data 
>> files manipulated, etc.).  No iptables/chains.
>>
>> The mount is automounted,  the resulting mtab entry on IRIX is:
>
>
>
>  Are you using amd or autofs?  Does it occur when you manually mount 
> the share? "mount lego:/export/turb3 /data/turb3"
>
Followup: We changed the nfs mount options to mount with NFSv2 and have 
not been able to reproduce the problem, yet.


