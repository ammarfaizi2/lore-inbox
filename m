Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317925AbSFSQVO>; Wed, 19 Jun 2002 12:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317926AbSFSQVN>; Wed, 19 Jun 2002 12:21:13 -0400
Received: from h24-68-93-250.vc.shawcable.net ([24.68.93.250]:48770 "EHLO
	me.bcgreen.com") by vger.kernel.org with ESMTP id <S317925AbSFSQVL>;
	Wed, 19 Jun 2002 12:21:11 -0400
Message-ID: <3D10AF67.20204@bcgreen.com>
Date: Wed, 19 Jun 2002 09:20:55 -0700
From: Stephen Samuel <samuel@bcgreen.com>
Organization: Just Another Radical
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Shipman, Jeffrey E" <jeshipm@sandia.gov>,
       inux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: GPL module question
References: <03781128C7B74B4DBC27C55859C9D73809840643@es06snlnt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that this one depends on where/how you're
using and distributing the module. (I remember
hearing that special dispensation was given for
drivers but I can't really comment).

The biggest question is whether or not you're distributing
copies of Linux, or other drivers. If you're not making
copies of other people's GPL code, then you don't have to
distribute the source to your code to your driver. This
is because the GPL really only kicks in when you
redistribute GPL code .. not when you distribute your own.

Where not distributing source code may bite you, however
is getting OS distribution makers (e.g. RedHat, SuSe,
Debian) to include copies of your drivers with their
distribution. It is at best borderline, and at worst
illegal to do so. If you've read the GPL, you'll notice
that breaching the GPL code means that you COMPLETELY
LOSE the ability to redistribute The GPL code.

For a company/group for whom their entire reason for
being is the distribution of Linux, losing the right
to do so is a pretty high risk to take for a simple
driver.

--------
--------
For a longer answer: If you are intending to try and
distribute GPL code alongside your own non-open code,
I'd trongly suggest that you hand the whole question
off to a set of high-paid lawyers. You'll be putting
your business model into the  middle of a legal mine
field (presuming you don't start *on top* of a mine).
Under those conditions, putting your business into the
hands of the legal opinion of a bunch of programmers
would be *stupid*.

On the other hand, if you GPL your code, then you'll
be fine.  If your business is selling hardware, then
there's little real loss in making the code available
and lots of advantages (like making it FAR more likely
that Linux distributions will include your drivers).


Shipman, Jeffrey E wrote:
> I hope this is not off-topic. If it is, please point
> me in the right direction.
> 
> I'm currently writing a Linux Kernel module. Does
> this have to be under the GPL because it uses kernel
> routines? I really don't know of a way around
> using kernel routines because that's whatcha gotta
> do inside the kernel. :)
> 
> Hopefully this won't be an issue (it's not classified
> material or anything). I'm still waiting for my
> manager to get back to me on it.
> 
> Jeff Shipman - CCD
> Sandia National Laboratories
> (505) 844-1158 / MS-1372
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Stephen Samuel +1(604)876-0426                samuel@bcgreen.com
		   http://www.bcgreen.com/~samuel/
Powerful committed communication, reaching through fear, uncertainty and
doubt to touch the jewel within each person and bring it to life.

