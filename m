Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130927AbRBWDUM>; Thu, 22 Feb 2001 22:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131002AbRBWDUC>; Thu, 22 Feb 2001 22:20:02 -0500
Received: from light.jjm.com ([216.254.68.208]:34714 "EHLO light.jjm.com")
	by vger.kernel.org with ESMTP id <S130927AbRBWDTy>;
	Thu, 22 Feb 2001 22:19:54 -0500
Date: Thu, 22 Feb 2001 22:19:51 -0500 (EST)
From: Jim Murray <jjm@jjm.com>
To: <jeff@CYTE.COM>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2 seems to break loopback and/or mount
In-Reply-To: <Pine.LNX.4.21.0102221714370.1662-100000@stingray.ntcor.com>
Message-ID: <Pine.LNX.4.30.0102222215190.8939-100000@light.jjm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Feb 2001 jeff@CYTE.COM wrote:

Compiling with kgcc compiler from RedHat 7.0 breaks loopback in the
way you describe on 2.4.2-prex kernels and I suspect also in the real 2.4.2.

Jim

> Please CC me on replies. I just joined the list and don't want
> to miss any replies.
>
> I have been running 2.4.1-pre10 for quite some time with no
> problems. I just upgraded to 2.4.2 and everything seem to work
> fine until I did...  (as root or course)
>
> mount -t iso9660 -o loop,ro mycdimage.iso /mnt/cdrom
>
> at which point the mount process hung in an uninterruptable sleep.
> after that I can no longer successfully issue any other mount
> commands, including non-loopback mounts. I can mount/unmount
> regular partitions before mounting anything via loopback.
>
> Any ideas as to what is wrong?
> The only thing I can think of is that my modutils is v2.3.19
> but I doubt that is doing it as the loop module and other modules
> are loaded fine.
>
> If anybody has an idea as to what I broke please let me know.
> I will upgrade modutils tomorrow and see if the problem goes
> away while I wait for a possibly more accurate response.
>
> Thank you,
>
> Jeff Wiegley
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
Jim Murray         jjm@jjm.com

