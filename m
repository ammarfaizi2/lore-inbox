Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313579AbSDHHwE>; Mon, 8 Apr 2002 03:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313580AbSDHHwD>; Mon, 8 Apr 2002 03:52:03 -0400
Received: from 12-234-33-29.client.attbi.com ([12.234.33.29]:3142 "HELO
	top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S313579AbSDHHwC>; Mon, 8 Apr 2002 03:52:02 -0400
From: brian@worldcontrol.com
Date: Mon, 8 Apr 2002 00:47:29 -0700
To: Pavel Machek <pavel@ucw.cz>
Cc: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Make swsusp actually work better
Message-ID: <20020408074729.GA1634@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	Pavel Machek <pavel@ucw.cz>, alan@redhat.com,
	kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020407233725.GA15559@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2002 at 01:37:26AM +0200, Pavel Machek wrote:
> Hi!
> 
> There were two bugs, and linux/mm.h one took me *very* long to
> find... Well, those bits used for zone should have been marked. Plus I
> hack ide_..._suspend code not to panic, and it now seems to
> work. [Sorry, 2pm, have to get some sleep.]

I can suspend without oopses.  Yeh!

However, during the boot '2419p5a3 resume=/dev/hda6'  it oopses right
after saying a couple of things about not being able to determine
blocksize.  I'll photograph the repeatable oops and get it to you
when I have access to my camera again.  Probably in the next
24 hours. 

Do I need APM compiled into the kernel?


> (about SSSCA) "I don't say this lightly.  However, I really think that
> the U.S. no longer is classifiable as a democracy, but rather as a
> plutocracy." --hpa

The US was never a democracy.  It was a constitutional republic.
Be that as it may, Thomas Hobbes wrote that there are only three
kinds of governments: Monarchies, Democracies, and Aristocracies.
All the rest of kinds and types are just versions of those already
mentioned.  The US is not a Democracy by any definition
so clearly I cannot choose the glass in front of me...

While the country may aspire to be a constitutional republic,
it seems to operate by the golden rule mixed with a bit of 
thuggery, so clearly I cannot choose the glass in front of you...
Are there countries that operate differently?

-- 
Brian Litzinger <brian@worldcontrol.com>

    Copyright (c) 2002 By Brian Litzinger, All Rights Reserved
