Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265141AbUGZKo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbUGZKo0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 06:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265154AbUGZKo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 06:44:26 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:3520 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S265141AbUGZKoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 06:44:24 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: Autotune swappiness01
Date: Mon, 26 Jul 2004 12:54:01 +0200
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <cone.1090801520.852584.20693.502@pc.kolivas.org> <200407261234.29565.rjwysocki@sisk.pl> <4104DD27.6050907@kolivas.org>
In-Reply-To: <4104DD27.6050907@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407261254.01186.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 of July 2004 12:29, Con Kolivas wrote:
> R. J. Wysocki wrote:
> > On Monday 26 of July 2004 11:31, Con Kolivas wrote:
> >>R. J. Wysocki wrote:
> >>>On Monday 26 of July 2004 03:09, Con Kolivas wrote:
> >>>>Con Kolivas writes:
> >>>>>Andrew Morton writes:
> >>>>>>Seriously, we've seen placebo effects before...
> >>>>>
> >>>>>I am in full agreement there... It's easy to see that applications do
> >>>>>not swap out overnight; but i'm having difficulty trying to find a way
> >>>>>to demonstrate the other part. I guess timing the "linking the kernel
> >>>>>with full debug" on a low memory box is measurable.
> >>>>
> >>>>I should have said - finding a swappiness that ensures not swapping out
> >>>>applications with updatedb, then using that same swappiness value to do
> >>>>the linking test.
> >>>
> >>>Please excuse me, but is that viable at all?  IMHO, it's just like
> >>> trying to tune a radio including volume with only one knob.  I don't
> >>> say it won't work, but the probability that it will is rather small, it
> >>> seems ...
> >>
> >>Well that's what we want. I cant remember other desktop operating
> >>systems setting a root only control between night and day, or between
> >>copying ISOs and running applications or...
> >
> > I agree, but isn't it related to the fact that other desktop OSes usually
> > don't run anything like updatedb nightly?
> >
> > Perhaps we need a bit more sophisticated swap algorithm than other OSes
> > do. For example, couldn't we add an additional parameter to control the
> > swapping "behavior", apart from the swappiness?  Something like adding
> > the second knob in my radio example?  Just thinking,
>
> I think one knob is one knob too many already.

Can you please tell me why do you think so?

rjw

-- 
Rafael J. Wysocki
[tel. (+48) 605 053 693]
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
