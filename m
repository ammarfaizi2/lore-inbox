Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277950AbRJVGvn>; Mon, 22 Oct 2001 02:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278004AbRJVGvX>; Mon, 22 Oct 2001 02:51:23 -0400
Received: from [12.2.11.164] ([12.2.11.164]:52754 "EHLO www.bradycorp.com")
	by vger.kernel.org with ESMTP id <S277950AbRJVGvP> convert rfc822-to-8bit;
	Mon, 22 Oct 2001 02:51:15 -0400
Subject: Re: kapmidled and AMD K6-2
To: pavel@suse.cz
Cc: davej@suse.de, kernel@Expansa.sns.it, linux-kernel@vger.kernel.org,
        pavel@suse.cz
X-Mailer: Lotus Notes Edition France 5.0.2c 8 =?iso-8859-1?q?f=E9vrier_2000?=
Message-ID: <OFF593B565.D426BBBC-ONC1256AED.00261FC7@bradycorp.com>
From: Jose_Jorge@teklynx.fr
Date: Mon, 22 Oct 2001 07:57:32 +0100
X-MIMETrack: Serialize by Router on GHOWBL01/BradyWeb(Release 5.0.5 |September 22, 2000) at
 10/22/2001 01:39:40 AM
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I say too hot, I mean as hot as when full-loaded when it is idle.

More precisely, less than 30°C when I am watching TV, so that I don't hear
the CPU fan!

José

/----------------------------------------------------------------------------\


|          José Jorge <jose_jorge@teklynx.fr>            |
| TEKLYNX International http://www.teklynx.com |
\----------------------------------------------------------------------------/


                                                                                                                                 
                    Pavel Machek                                                                                                 
                    <pavel@suse.c        To:     Luigi Genoni <kernel@Expansa.sns.it>, Pavel Machek <pavel@suse.cz>              
                    z>                   cc:     Dave Jones <davej@suse.de>, Jose_Jorge@teklynx.fr, linux-kernel@vger.kernel.org 
                                         Subject:     Re: kapmidled and AMD K6-2                                                 
                    19/10/2001                                                                                                   
                    21:05                                                                                                        
                                                                                                                                 
                                                                                                                                 



Hi!

> Excuse me, I ma quite curious. I had 50 K6-2, (from 350 to 500 Mhz), in
> the SNS CED, so I would like to know when you say it is too hot, what
> temperature are you talking about? In my experience I had some k6
> 500 working
> for 360 days continously fully loaded with a temperature of 55 degrees on
> the processor, and it was ever stable. On the other side, I saw a 450 Mhz
> processor to be unstable being ideld at 50 degrees (the fan was
> not properly working). I have a quite good idea when a K6 could be
> damnaged by temperature. Ohh, that is really important, did you make some
> burn in to your processors?

On my k6-2, cpu fan starts cooling on 30 celsia. But I do not know
where the sensor is ;-)


> Luigi
>
>
> On Fri, 12 Oct 2001, Pavel Machek wrote:
>
> > Hi!
> >
> > > > for the AMD K6-2 on a DFI motherboard AT/ATX, using the AT power
supply,
> > > > this option is buggy. I mean the cycles kapmidled works doesn't
cool the
> > > > processor, they hot him.
> > >
> > > Initially, I thought was odd. The spec seemed straight forward
> > > enough, and doesn't say we have to do any special magic.
> > > Just that "During the execution of the HLT instruction, the AMD-K6-2
> > > processor executes a Halt special cycle."
> > >
> > > The next bit is interesting however..
> > >
> > > "After BRDY# is sampled asserted during this cycle, and then EWBE#
> > > is also sampled asserted (if not masked off), the processor enters
> > > the halt state in which the processor disables most of its internal
> > > clock distribution."
> > >
> > > EWBE is a feature that is enabled with bits 2-3 of the EFER MSR.
> > > This controls the behaviour of the CPU with respect to ordering
> > > of write cycles. Behaviour here can affect performance, and from
> > > my interpretation of the above, the amount of power saving that
> > > is possible.
> > >
> > > You can control the EWBE register using powertweak
> > > (http://www.powertweak.org), but if you don't want to/are unable
> > > to build that, and want to do some further tests, let me know
> > > and I'll hack something up.
> >
> > If I don't want to build powertweak, are you willing to hack something
up
> > for me? ;-). [My k6-2 is too hot to slow down CPU fan. I tried
throttling
> > it using ACPI, but no success. I want to cool it down so that fan slows
> > and machine becomes quiet.]


--
STOP THE WAR! Someone killed innocent Americans. That does not give
U.S. right to kill people in Afganistan.






