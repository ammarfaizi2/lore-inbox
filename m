Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268133AbRIDTfa>; Tue, 4 Sep 2001 15:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268286AbRIDTfU>; Tue, 4 Sep 2001 15:35:20 -0400
Received: from h157s242a129n47.user.nortelnetworks.com ([47.129.242.157]:36560
	"EHLO zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S268133AbRIDTfH>; Tue, 4 Sep 2001 15:35:07 -0400
Message-ID: <3B952CFE.A3B6FF95@nortelnetworks.com>
Date: Tue, 04 Sep 2001 15:35:26 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Cc: Fred <fred@arkansaswebs.com>, linux-kernel@vger.kernel.org
Subject: Re: Should I use Linux to develop driver for specialized ISA card?
In-Reply-To: <E15eHup-0003ir-00@the-village.bc.nu> <01090410264000.14864@bits.linuxball> <3B950034.17909E5D@nortelnetworks.com> <200109041823.f84INqE13918@maild.telia.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Larsson wrote:
> 
> On Tuesday den 4 September 2001 18:24, Christopher Friesen wrote:
> > Fred wrote:
> > > I'm  curious, Alan, Why? I'm a hardware developer, and I would have
> > > assumed that linux would have been ideal for real time / embedded
> > > projects? (routers / controllers / etc.) Is there, for instance, a reason
> > > to suspect that linux would not be able to respond to interrupts at say
> > > 8Khz?
> > > of course I know nothing of rtlinux so I'll read.
> >
> > I'm involved in a project where we are using linux in an embedded
> > application. We've got a gig of ram, no hard drives, no video, and the only
> > I/O is serial, ethernet and fiberchannel.
> >
> > We have a realtime process that tries to run every 50ms.  We're seeing
> > actual worst-case scheduling latencies upwards of 300-400ms.

> 1) Why shouldn't the low-latency patches work for another architecture?
> Andrew Morton might be interested to fix other architectures too.
> (but most patches are not in architecture specific code)

Well, a while back I took a look at the low latency patch and saw a bunch of
arch-specific files being modified so I assumed that it wouldn't do much on a
different architecture.  I may have been wrong.  I guess its time for me to do
some testing.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
