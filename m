Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264236AbTEXKkF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 06:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264237AbTEXKkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 06:40:04 -0400
Received: from mail.ithnet.com ([217.64.64.8]:25351 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S264236AbTEXKkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 06:40:03 -0400
Date: Sat, 24 May 2003 12:52:52 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: gibbs@scsiguy.com, willy@w.ods.org, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes
Message-Id: <20030524125252.58507d98.skraw@ithnet.com>
In-Reply-To: <20030523195757.GA27557@alpha.home.local>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<20030523195757.GA27557@alpha.home.local>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 May 2003 21:57:57 +0200
Willy Tarreau <willy@w.ods.org> wrote:

> Hello !
> 
> On Fri, May 23, 2003 at 06:58:41AM -0600, Justin T. Gibbs wrote:
> > > Ok. I managed to crash the tested machine after 14 days now. The crash
> > > itself is exactly like former 2.4.21-X. It just freezes, no oops no
> > > nothing. It looks like things got better, but not solved.
> > 
> > What is telling you that the freeze is SCSI related?  Are you running
> > with the nmi watchdog and have a trace?  Do you have driver messages
> > that you aren't sharing?
> 
> Stephen,
> 
> Justin is right, you should run it through the NMI watchdog, in the hope to
> find something useful. If it hangs again in 14 days, you won't know why and
> that may be frustrating. With the NMI watchdog, you at least have a chance to
> see where it locks up, and you may find it to be within the driver, which
> would help Justin stabilize it, or within any other kernel subsystem.
> 
> I had to use nmi_watchdog=2 at boot time, but other people use 1.
> 
> Regards,
> Willy

Hello Willy,

I will do that, but I am not so confident about this, because the box runs X
and a console oops output from nmi may as well not be visible nor written to
disk.

Regards,
Stephan


