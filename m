Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261756AbSJMXpr>; Sun, 13 Oct 2002 19:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261767AbSJMXpr>; Sun, 13 Oct 2002 19:45:47 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:62472 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S261756AbSJMXpq>; Sun, 13 Oct 2002 19:45:46 -0400
Message-ID: <3DAA0708.1030701@namesys.com>
Date: Mon, 14 Oct 2002 03:51:36 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Landley <landley@trommello.org>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not
 3.0 - (NUMA))
References: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com> <20021012012807.1BB5B635@merlin.webofficenow.com> <3DA7F385.3040409@namesys.com> <200210132242.g9DMgVng334662@pimout3-ext.prodigy.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:

>On Saturday 12 October 2002 06:03 am, Hans Reiser wrote:
>  
>
>>Rob Landley wrote:
>>    
>>
>>>I'm also looking for an "unmount --force" option that works on something
>>>other than NFS.  Close all active filehandles (the programs using it can
>>>just deal with EBADF or whatever), flush the buffers to disk, and
>>>unmount.  None of this "oh I can't do that, you have a zombie process
>>>with an open file...", I want  "guillotine this filesystem pronto,
>>>capice?" behavior.
>>>      
>>>
>>This sounds useful.  It would be nice if umount prompted you rather than
>>refusing.
>>    
>>
>
>The problem here is that umount(2) doesn't take a flag.  I'd be happy to have 
>it fail unless called with the WITH_EXTREME_PREJUDICE flag or some such, but 
>that's an API change.
>
>Of course I haven't gotten that far yet, but eventually this will have to be 
>dealt with...
>
>Rob
>
>
>  
>
Call it forcedumount().

What apps need to know about how to call it besides umount anyway?

Not a lot that need a lot of worry.....

Hans


