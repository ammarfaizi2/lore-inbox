Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132738AbRA3WUi>; Tue, 30 Jan 2001 17:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132753AbRA3WU3>; Tue, 30 Jan 2001 17:20:29 -0500
Received: from [209.143.110.29] ([209.143.110.29]:37644 "HELO
	mail.the-rileys.net") by vger.kernel.org with SMTP
	id <S132651AbRA3WUN>; Tue, 30 Jan 2001 17:20:13 -0500
Message-ID: <3A773E70.804BEAB@the-rileys.net>
Date: Tue, 30 Jan 2001 17:21:36 -0500
From: David Riley <oscar@the-rileys.net>
Organization: The Riley Family
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: *massive* slowdowns on 2.4.1-pre1[1|2]
In-Reply-To: <3A761FEC.1C564FAE@the-rileys.net> <Pine.LNX.4.10.10101292102030.28124-100000@coffee.psychology.mcmaster.ca> <955pr6$afk$1@penguin.transmeta.com> <20010131001452.A6620@metastasis.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
> On Mon, Jan 29, 2001 at 11:17:58PM -0800, Linus Torvalds wrote:
> 
>     You have to realize that stability takes precedence over
>     EVERYTHING.
> 
> Are you sure his desciption describes only disk-slow down? Seems to
> me something else is going on... why would speaker beeps take longer?
> Maybe some kind of PM weirdo?

My problem had nothing to do with disk access. Keyboard input isn't
slowed by disk access.  I knew that... In any case, sub-486 speeds
aren't attained through using PIO instead of UDMA... my 486 uses PIO
disks anyway, so it's moot.  The real culprit was ACPI, which is having
some temporary problems.  I turned it off and everything's great
(thanks, Andrew).
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
