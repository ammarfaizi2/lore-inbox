Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282456AbRKZT4l>; Mon, 26 Nov 2001 14:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282443AbRKZT41>; Mon, 26 Nov 2001 14:56:27 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:51207 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S282456AbRKZTzM>; Mon, 26 Nov 2001 14:55:12 -0500
Date: Mon, 26 Nov 2001 14:48:46 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15-pre1:  "bogus" message with reiserfs root and other weirdness
In-Reply-To: <87elmlmn81.fsf@devron.myhome.or.jp>
Message-ID: <Pine.LNX.3.96.1011126144754.27112B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001, OGAWA Hirofumi wrote:

> Bill Davidsen <davidsen@tmr.com> writes:
> 
> > On 27 Nov 2001, OGAWA Hirofumi wrote:
> > 
> > > davidsen@tmr.com (bill davidsen) writes:
> > 
> > Actually the original poster used "magic" and I didn't quibble, but I
> > believe you're right. I just noted that it is better to check to see if
> > the filesystem is FAT before reporting the error message. Obviously this
> > can be done, since you don't get the message with FAT as a module, I just
> > haven't looked to see if the check is in the module or the kernel before
> > even loading the FAT module.
> 
> Yes. You can't use the module before you mounted the root filesystem.
> This is a reason for not seeing an error message.

What? Of course you can! That's what initd files are for ;-) 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

