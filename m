Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262043AbTCLVID>; Wed, 12 Mar 2003 16:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262045AbTCLVID>; Wed, 12 Mar 2003 16:08:03 -0500
Received: from zeke.inet.com ([199.171.211.198]:64921 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S262043AbTCLVH5>;
	Wed, 12 Mar 2003 16:07:57 -0500
Message-ID: <3E6FA426.2020601@inet.com>
Date: Wed, 12 Mar 2003 15:18:30 -0600
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Nicolas Pitre <nico@cam.org>, Sam Ravnborg <sam@ravnborg.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
References: <20030312201416.GA2433@mars.ravnborg.org> <Pine.LNX.4.44.0303121542010.14172-100000@xanadu.home> <20030312205859.GG7275@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> On Wed, Mar 12, 2003 at 03:46:58PM -0500, Nicolas Pitre wrote:
> 
>>It seems that some things that should have been attributed to me (or others)
>>are listed as from torvalds too.
>>
>>Example: drivers/char/tty_io.c
>>
>>revision 1.59
>>date: 2003/03/04 02:13:05;  author: torvalds;  state: Exp;  lines: +4 -6
>>small tty irq race fix
>>
>>(Logical change 1.8144)
> 
> 
> Yeah, I'm almost there, I'm pretty sure that what is happening is that 
> the user name is being picked up from the changeset which is current in
> the path.  We extract the user name and put it in the comments but I 
> don't see where we set $LOGNAME before doing the ci.
> 
> So here's a question.  Suppose we have a series of deltas being clumped
> together in a file.  All made by different people.  Whose name wins?
> My gut is to sort them, run them through uniq -c, and take the top one.
> The other idea is to count up lines inserted/deleted over each delta
> and take the user who has done the most work.
> 
> Thoughts?

Another option:
Choose the name that _removed_ the most lines.

Reward the desired behaviour. ;)

Wha?  Right, back to work.

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

