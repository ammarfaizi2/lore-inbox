Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312634AbSEHKGH>; Wed, 8 May 2002 06:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312681AbSEHKGG>; Wed, 8 May 2002 06:06:06 -0400
Received: from [195.63.194.11] ([195.63.194.11]:18951 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312634AbSEHKGF>; Wed, 8 May 2002 06:06:05 -0400
Message-ID: <3CD8E9D1.1010309@evision-ventures.com>
Date: Wed, 08 May 2002 11:03:13 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Guest section DW <dwguest@win.tue.nl>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <5.1.0.14.2.20020507153451.02381ec0@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0205070827050.1343-100000@home.transmeta.com> <20020507162010.GA13032@ravel.coda.cs.cmu.edu> <3CD7F212.5090608@evision-ventures.com> <20020507213603.GA18535@ravel.coda.cs.cmu.edu> <20020508002513.GA26150@win.tue.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Guest section DW napisa?:
> On Tue, May 07, 2002 at 05:36:03PM -0400, Jan Harkes wrote:
> 
>>On Tue, May 07, 2002 at 05:26:10PM +0200, Martin Dalecki wrote:
>>
>>>Uz.ytkownik Jan Harkes napisa?:
>>>
>>>>I'm still hoping a patch will show up that will allow me to regain
>>>>access to my compactflash cards and IBM microdrive disks. The code
>>>>currently doesn't rescan for new drives when a card has been inserted,
>>>>although it still seems to have all the necessary logic.
>>>
>>>Yes I'm fully aware of this, but the whole initialization
>>>is currently much in flux and I will return to this issue back
>>>if I think that things are in shape there. OK?
>>
>>I thought so, you already indicated so around the time that it broke.
>>There is still a 2.4 kernel when I really need to get to the data.
> 
> 
> I usually do
> 
> 	blockdev --rereadpt /dev/sde
> 
> or so. That still works for me with 2.5.13.


What you have to do by hand now is the rescanning for partition
information. What you do is triggering just that. And if I think
about it... and you know I'm evil... hmmm...
well why just don't let it be like that. It's functionally somehow the
responsibility of the /sbin/hotplug thing anyway...

