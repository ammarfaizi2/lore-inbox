Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281205AbRKYXSH>; Sun, 25 Nov 2001 18:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281197AbRKYXR5>; Sun, 25 Nov 2001 18:17:57 -0500
Received: from hall.mail.mindspring.net ([207.69.200.60]:28726 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S281205AbRKYXRr>; Sun, 25 Nov 2001 18:17:47 -0500
Message-ID: <3C017C1B.8B8610DE@mindspring.com>
Date: Sun, 25 Nov 2001 16:17:47 -0700
From: Jim Henderson <hendersj@mindspring.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: J Sloan <jjs@pobox.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM:  kernel BUG at filemap.c:791
In-Reply-To: <3C016E08.3C2D2537@mindspring.com> <3C017A6E.A4A3E2A6@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan wrote:
> Wow, it must have taken quite some effort
> to patch a 2.2 kernel for ext3!
> 
> OK, assuming you really mean 2.4.14, there
> is a patch floating around the list for that -

You are correct, I fat-fingered the kernel version, 2.4.14 is what I'm
running.  Been running 2.4.x kernels for quite a while now, and I catch
myself freqently making that mistake when I type the version.

> I had a compaq 6500 that would scribble
> on the disk and then lock up hard at some
> random point in time - but that behaviour
> could be triggered immediatley by running
> dbench  - Look for the compaq patches from
> Jens Axboe or better yet, lose 2.4.14 and go
> straight to 2.4.16-pre1, since it has the ida
> raid fixes, and ext3 support already.

Will give the 2.4.16-pre1 kernel a shot and see how it behaves.

I should have mentioned in my intial post as well that I've seen both
hard locks (as in this case) and soft locks (where I could use the
'magic sysreq key' feature), both of which referenced this particular
code segment.

Thanks for the quick response.

Jim
