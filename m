Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbSJNCgL>; Sun, 13 Oct 2002 22:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261802AbSJNCgL>; Sun, 13 Oct 2002 22:36:11 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:12042 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S261799AbSJNCgK>; Sun, 13 Oct 2002 22:36:10 -0400
Message-ID: <3DAA2EF9.2090408@namesys.com>
Date: Mon, 14 Oct 2002 06:42:01 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Rob Landley <landley@trommello.org>, Nick LeRoy <nleroy@cs.wisc.edu>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not
 3.0 - (NUMA)) (fwd)
References: <Pine.GSO.4.21.0210132107020.9247-100000@steklov.math.psu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:

>  
>
>>Logically, the second /var mount should be "mount --move /initrd/var /var", 
>>followed by "umount /initrd" to free up the initrd memory.  Right now it's 
>>doing "mount -n --bind /initrd/var /var", because /etc is a symlink into /var 
>>(has to remain editable, you see), and this way the information about which 
>>partition var actually is can be kept in one place.  (This is an 
>>implementation detail: I could have used volume labels instead.)
>>
>>The point is, right now I can't free the initial ramdisk because it has an 
>>active mount point under it..
>>    
>>
>
>umount -l
>mount --move
>
>
>
>
>  
>
It seems Linux evolves faster than I can track.  These are nice features.:)

Hans


