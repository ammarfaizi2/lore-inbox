Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131246AbRDPQFm>; Mon, 16 Apr 2001 12:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131233AbRDPQFd>; Mon, 16 Apr 2001 12:05:33 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:42763 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id <S131563AbRDPQFS>;
	Mon, 16 Apr 2001 12:05:18 -0400
Message-ID: <3ADB1837.A0AE3020@linux-m68k.org>
Date: Mon, 16 Apr 2001 18:05:11 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: markh@compro.net
CC: linux-kernel@vger.kernel.org
Subject: Re: amiga affs support broken in 2.4.x kernels??
In-Reply-To: <3AD59EB9.35F3A535@compro.net> <3AD9FEDD.2B636582@linux-m68k.org> <3ADAEA9B.D70DC130@compro.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Mark Hounschell wrote:

> Thanks, I can now mount affs filesystems. However when I try to write
> to it via "cp somefile /amiga/somefile" I get a segmentation fault. If
> I then do a "df -h" it hangs the system very much like the mount command
> did before I installed your tar-ball. Was write support expected from
> it.

Yes, it should work.
What sort of filesystem is it (ffs or ofs)? Did you check the dmesg
output for an oops? Which kernel version did you use?

> Are you the NEW maintainer of the affs stuff.

Yes and as soon this problem is solved, I'm sending the changes to Linus
and Alan.

bye, Roman
