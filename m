Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135886AbREDHoA>; Fri, 4 May 2001 03:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135900AbREDHnk>; Fri, 4 May 2001 03:43:40 -0400
Received: from femail4.sdc1.sfba.home.com ([24.0.95.84]:22971 "EHLO
	femail4.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S135886AbREDHna>; Fri, 4 May 2001 03:43:30 -0400
Message-ID: <3AF25D9A.982B040B@home.com>
Date: Fri, 04 May 2001 00:43:22 -0700
From: Seth Goldberg <bergsoft@home.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gordon Sadler <gbsadler1@lcisp.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.5pre1 will not boot
In-Reply-To: <20010504021243.A8621@debian-home.lcisp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   What hardware are you running?

  --seth
 

> 
> Please CC any replies.
> Please refer to my previous post 'PROBLEM: 2.4.4 oops, will not boot'
> for complete machine details/configuration.
> 
> I'm still working on different 2.4 kernels trying to get just one to
> boot normally. Currently I've removed all modules and built everything
> into the kernel, that seems to help a 'little'.
> 
> Just tried 2.4.5pre1...
> 
> 1st boot. Got as far as "Checking all file systems...", which is:
>   fsck -C -R -A -a  (Debian Sid). This was followed by numerous (>50)
>   lines of the form:
>   memory.c: 83  (something I couldn't read fast enough)
>   followed by the machine auto-rebooting.
> 
> 2nd boot. Trying to duplicate to read above memory.c ...
>   Led to the attached oops.txt > ksym.out contained in the tarball.
> 
> 3rd boot. I was actually able to login... for about 5 mins. I attempted
>   to run the above oops through ksymoops while kernel was running. It
>   appeared to work, just then machine froze, required my using reset
>   button on case. This led to booting back into 2.2.19 with duplicate
>   inodes, manual run of fsck.
> 
> 4th boot. Led to the attached oops2.txt > ksym2.out which was just the
>   first oops of approx. 20 or more before machine froze. All the
>   remaining oops (that I looked at) were of the same type/address.
> 
> I really hope someone finds this, Andrew Morton(sp?) was looking into my
> 2.4.4 oops, says my slab is being corrupted? Would be kind of
> interesting to find out it is hardware related. This m/b and CPU are
> brand new, can still take them back -)
> 
> Thanks for your time.
> 
> Gordon Sadler
> 
> 
> 
> 
>                             Name: 2.4.5pre1.oops.tar.gz
>    2.4.5pre1.oops.tar.gz    Type: Unix Tape Archive (application/x-tar)
>                         Encoding: base64
