Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264894AbUBIGNM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 01:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUBIGNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 01:13:12 -0500
Received: from [221.216.156.66] ([221.216.156.66]:26362 "EHLO
	kapok.exavio.com.cn") by vger.kernel.org with ESMTP id S264894AbUBIGNH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 01:13:07 -0500
Date: Mon, 9 Feb 2004 14:15:32 +0800
From: Isaac Claymore <clay@exavio.com.cn>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: psmouse.c, throwing 3 bytes away
Message-ID: <20040209061532.GA486@exavio.com.cn>
Mail-Followup-To: Isaac Claymore <clay@exavio.com.cn>,
	kernel list <linux-kernel@vger.kernel.org>
References: <200402041820.39742.wnelsonjr@comcast.net> <200402050454.44936.ctpm@rnl.ist.utl.pt> <20040205102023.GB497@exavio.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205102023.GB497@exavio.com.cn>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 06:20:23PM +0800, Isaac Claymore wrote:
> On Thu, Feb 05, 2004 at 04:54:44AM +0000, Claudio Martins wrote:
> > 
> > On Thursday 05 February 2004 02:20, Walt Nelson wrote:
> > > My mouse has been acting wired occationally, not all the time. I receive
> > > the following error in the syslog. This has been happening since 2.6.2-RC3.
> > > I am currently using 2.6.2. Are these related?
> > >
> > > Feb  4 13:56:02 gumby kernel: psmouse.c: Wheel Mouse at
> > > isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.
> > >
> > > The following occurs when starting KDE/X.
> > > Feb  4 18:05:11 gumby kernel: atkbd.c: Unknown key released (translated set
> > > 2, code 0x7a on isa0060/serio0).
> > > Feb  4 18:05:11 gumby kernel: atkbd.c: This is an XFree86 bug. It shouldn't
> > > access hardware directly.
> > > Feb  4 18:05:11 gumby kernel: atkbd.c: Unknown key released (translated set
> > > 2, code 0x7a on isa0060/serio0).
> > > Feb  4 18:05:11 gumby kernel: atkbd.c: This is an XFree86 bug. It shouldn't
> > > access hardware directly.
> > >
> > 
> > 
> >   I saw the same here yesterday, using a logitech wheel mouse:
> > 
> > Feb  4 18:19:46 vega kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 
> > lost synchronization, throwing 2 bytes away.
> > 
> >   Before this happened the mouse in X just went nuts with random clicks in 
> > many windows, but after that it's been ok up to now.
> > 
> I've been suffering this same problem ever since upgrade to 2.6 kernel.
> 
> FYI, here is an article giving some possible solutions to this, but I
> failed to fix my mouse problem by any method it suggests:
> 
> http://kerneltrap.org/node/view/2199
> 
> 

Just FYI:

This annoying mouse problem hasn't shown up for 3 days, after I did a 
'hdparm -u1 /dev/hda'. But be sure to read the hdparm man page before 
doing this on your box.


> >   FYI the mouse is detected as: 
> > 
> > Feb  4 08:57:42 vega kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
> > Feb  4 08:57:42 vega kernel: input: PS2++ Logitech Wheel Mouse on 
> > isa0060/serio1
> > 
> >   The motherboard is an Intel 440BX2 with a PII-350 running kernel 2.6.2.
> > 
> > Thanks 
> > 
> > Claudio
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -- 
> 
> Regards, Isaac
> ()  ascii ribbon campaign - against html e-mail
> /\                        - against microsoft attachments
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

Regards, Isaac
()  ascii ribbon campaign - against html e-mail
/\                        - against microsoft attachments
