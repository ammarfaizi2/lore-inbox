Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbSJEPgp>; Sat, 5 Oct 2002 11:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262379AbSJEPgp>; Sat, 5 Oct 2002 11:36:45 -0400
Received: from mons.uio.no ([129.240.130.14]:59124 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S262377AbSJEPgl>;
	Sat, 5 Oct 2002 11:36:41 -0400
Message-ID: <3D9F084F.1020200@karlsbakk.net>
Date: Sat, 05 Oct 2002 17:42:07 +0200
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jakob Oestergaard <jakob@unthought.net>
CC: Kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
Subject: Re: AARGH! Please help. IDE controller fsckup
References: <200210021516.46668.roy@karlsbakk.net> <200210031225.11283.roy@karlsbakk.net> <20021003114020.GD7350@unthought.net> <200210031513.28459.roy@karlsbakk.net> <20021003132349.GE7350@unthought.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Oestergaard wrote:

>>>>But ... with persistent superblock - is it possible to fsckup the raid?
>>>>        
>>>>
>>>You're root, it is indeed possible  :)
>>>      
>>>
>>er - yes. I more meant like 'automagically'
>>    
>>
>
>It will only automagically screw up your arrays if you shuffle disks
>between machines (mix several RAID arrays from other systems in one
>system)  (you can of course move all your disks to one new machine, if
>it has none of it's original RAIDed disks left).
>
>Just don't mix disks with persistent superblocks from multiple machines
>into one single machine.  Unless you know exactly what you're doing.
>  
>
Could it be some kind of idea to 'sign' the disks with some hash out of 
hostname and  IP or something?

roy


