Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315124AbSDWJCq>; Tue, 23 Apr 2002 05:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315126AbSDWJCp>; Tue, 23 Apr 2002 05:02:45 -0400
Received: from [195.63.194.11] ([195.63.194.11]:5132 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S315124AbSDWJCo>;
	Tue, 23 Apr 2002 05:02:44 -0400
Message-ID: <3CC51494.8040309@evision-ventures.com>
Date: Tue, 23 Apr 2002 10:00:20 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Miles Lane <miles@megapathdsl.net>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.9 -- OOPS in IDE code (symbolic dump and boot log included)
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> I should probably add the /proc/ksyms snapshotting stuff to 
> get the module information for you as well.  I hope this 
> current batch of info helps, for starters.
> 
> ksymoops 2.4.4 on i686 2.4.7-10.  Options used
>      -v /usr/src/linux/vmlinux (specified)
>      -K (specified)
>      -L (specified)
>      -o /lib/modules/2.5.9/ (specified)
>      -m /boot/System.map-2.5.9 (specified)


Looks like the oops came from module code.
Which modules did you use: ide-flappy and ide-scsi are still
in need of the same medication ide-cd got.

