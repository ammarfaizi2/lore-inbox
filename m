Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293725AbSCPGBT>; Sat, 16 Mar 2002 01:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293726AbSCPGBJ>; Sat, 16 Mar 2002 01:01:09 -0500
Received: from flrtn-4-m1-42.vnnyca.adelphia.net ([24.55.69.42]:9614 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S293725AbSCPGAz>;
	Sat, 16 Mar 2002 01:00:55 -0500
Message-ID: <3C92DF96.6010904@tmsusa.com>
Date: Fri, 15 Mar 2002 22:00:54 -0800
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020207
X-Accept-Language: en-us
MIME-Version: 1.0
To: MrChuoi@yahoo.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre3-ac1
In-Reply-To: <E16lgjZ-0002Uh-00@the-village.bc.nu> <20020316052309.9B9F44E51A@mail.vnsecurity.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MrChuoi wrote:

>I think there are something wrong in MM of -ac tree. I can't build & run my
>project (~100 source files) from inside JBuilder4 anymore. JBuilder always
>reports that "cannot allocate memory".
>
>My system:
>CPU: K6-III 500Mhz
>Mem: 128Mb
>Swap: 64Mb
>
Why so stingy on the swap space?

>
>Linux From Scratch 3.1
>
>Tested with:
>2.4.19-pre3: OK
>2.4.19-pre2-ac4: cannot allocate memory
>2.4.19-pre3-ac1: cannot allocate memory
>2.4.19-pre2aa*: OK
>2.4.19-pre3aa*: OK
>

I'd bet they are all on the borderline -
It may be that you are simply exhausting vm.

What if you make a decent swap partition,
say 512 MB or so, and try the tests again?

Joe






