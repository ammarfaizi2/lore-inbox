Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289025AbSCCVlA>; Sun, 3 Mar 2002 16:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289046AbSCCVku>; Sun, 3 Mar 2002 16:40:50 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:42759 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289025AbSCCVkh>; Sun, 3 Mar 2002 16:40:37 -0500
Message-ID: <3C8218C3.6080204@namesys.com>
Date: Sun, 03 Mar 2002 15:36:19 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020123
X-Accept-Language: en-us
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Matti Aarnio <matti.aarnio@zmailer.org>,
        Doug McNaught <doug@wireboard.com>,
        "Doug O'Neil" <DougO@seven-systems.com>,
        lk <linux-kernel@vger.kernel.org>
Subject: Re: LFS Support for Sendfile
In-Reply-To: <036801c1bfee$b5b0f780$1801010a@Mauser> <m34rk2tn7h.fsf@varsoon.denali.to> <20020228100325.O23151@mea-ext.zmailer.org> <20020302222451.GB9590@tapu.f00f.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:

>On Thu, Feb 28, 2002 at 10:03:25AM +0200, Matti Aarnio wrote:
>
>    The API (kernel syscall) as defined does not support LFS.
>
>I wonder does it really need to?  I mean, a loop calling sendfile for
>2GB (or whatever) at a time is almost as good, if not better in some
>ways.
>
>    The "extent based" filesystems offer flatter performance, and
>    while I can't determine if ReiserFS is exactly of that type, it
>    too offers fast and flat performance.
>
>Reiserfs (v3) isn't extent based but does perform pretty well.  When I
>was messing large numbers of with (what at the time were) large files
>of 50GB or so, XFS proved to be very effective.
>
>
>  --cw
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
extents are in reiserfs v4.0 (September ship date), and should offer 
much improved performance for large files.

Hans


