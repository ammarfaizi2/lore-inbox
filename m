Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130069AbRBLVCA>; Mon, 12 Feb 2001 16:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130268AbRBLVBu>; Mon, 12 Feb 2001 16:01:50 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:50439 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130069AbRBLVBi>; Mon, 12 Feb 2001 16:01:38 -0500
Date: Mon, 12 Feb 2001 17:11:14 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Chris Mason <mason@suse.com>
cc: Hans Reiser <reiser@namesys.com>, Daniel Stone <daniel@kabuki.eyep.net>,
        Chris Wedgwood <cw@f00f.org>, David Rees <dbr@spoke.nols.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>,
        Alexander Zarochentcev <zam@namesys.com>
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
In-Reply-To: <107980000.981939371@tiny>
Message-ID: <Pine.LNX.4.21.0102121707350.29656-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 11 Feb 2001, Chris Mason wrote:

> 
> 
> On Sunday, February 11, 2001 10:00:11 AM +0300 Hans Reiser
> <reiser@namesys.com> wrote:
> 
> > Daniel Stone wrote:
> >> 
> >> On 11 Feb 2001 02:02:00 +1300, Chris Wedgwood wrote:
> >> > On Thu, Feb 08, 2001 at 05:34:44PM +1100, Daniel Stone wrote:
> >> > 
> >> >     I run Reiser on all but /boot, and it seems to enjoy corrupting my
> >> >     mbox'es randomly.
> >> > 
> >> > what kind of corruption are you seeing?
> >> 
> >> Zeroed bytes.
> > 
> > This sounds like the same bug as the syslog bug, please try to help Chris
> > reproduce it.
> > 
> > zam, if Chris can't reproduce it by Monday, please give it a try.
> > 
> 
> I had a bunch of scripts running over the weekend to try and reproduce
> this, but the results were ruined when a major storm killed the power (no,
> still haven't gotten around to configuring my UPS to shut things down ;-).
> 
> So, I'll try again.

Chris,

Do you know if the people reporting the corruption with reiserfs on
2.4 were using IDE drives with PIO mode and IDE multicount turned on?

If so, it may be caused by the problem fixed by Russell King on
2.4.2-pre2. 

Without his fix, I was able to corrupt ext2 while using PIO+multicount
very very easily.




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
