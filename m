Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312505AbSDNXvP>; Sun, 14 Apr 2002 19:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312511AbSDNXvO>; Sun, 14 Apr 2002 19:51:14 -0400
Received: from esteel10.client.dti.net ([209.73.14.10]:5009 "EHLO
	shookay.newview.com") by vger.kernel.org with ESMTP
	id <S312505AbSDNXvN>; Sun, 14 Apr 2002 19:51:13 -0400
To: spstarr@sh0n.net (Shawn Starr)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is this right?
In-Reply-To: <1018824351.290.1.camel@coredump>
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
Date: 14 Apr 2002 19:50:33 -0400
Message-ID: <xltbsclzvp2.fsf@shookay.newview.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes it is (and it's shared memory, not disk):
http://www.tux.org/lkml/#s14-3

spstarr@sh0n.net (Shawn Starr) writes:
> Should Buffers/Memshared be 0 kB? Is this memory buffers/shared or disk
> buffers/shared?
> 
> I'm using XFS filesystem.
> 
> [spstarr@coredump spstarr]$ cat /proc/meminfo 
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  62586880 61825024   761856        0        0 35803136
> Swap: 186654720 35758080 150896640
> MemTotal:        61120 kB
> MemFree:           744 kB
> MemShared:           0 kB
> Buffers:             0 kB
> 
> Shawn.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
    It is exactly because a man cannot do a thing that he is a
                      proper judge of it.
                      -- Oscar Wilde
