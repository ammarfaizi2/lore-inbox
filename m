Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266685AbUF3Oqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266685AbUF3Oqq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 10:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266686AbUF3Oqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 10:46:46 -0400
Received: from duchamp.tecgraf.puc-rio.br ([139.82.85.1]:33544 "EHLO
	tecgraf.puc-rio.br") by vger.kernel.org with ESMTP id S266685AbUF3Oqn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 10:46:43 -0400
Date: Wed, 30 Jun 2004 11:51:43 -0300
From: Andre Costa <costa@tecgraf.puc-rio.br>
To: tom st denis <tomstdenis@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.26: IDE drives become unavailable randomly
Message-Id: <20040630115143.3748d296.costa@tecgraf.puc-rio.br>
In-Reply-To: <20040630135907.98538.qmail@web41115.mail.yahoo.com>
References: <20040630084142.10a3598b.costa@tecgraf.puc-rio.br>
	<20040630135907.98538.qmail@web41115.mail.yahoo.com>
Organization: TecGraf
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please cc me on any replies, because I am not subscribed to this list)

Hi Tom,

On Wed, 30 Jun 2004 06:59:07 -0700 (PDT)
tom st denis <tomstdenis@yahoo.com> wrote:

> --- Andre Costa <costa@tecgraf.puc-rio.br> wrote:
> > (please cc me on any replies, because I am not subscribed to this
> > list;
> > if I do need to subscribe, just let me know)
> > 
> > Hi,
> > 
> > I am using 2.4.26 SMP on a ABIT AT7 mobo, with a 2.8GHz P4 processor
> > with hyper-threading enabled. I have one 80GB Seagate IDE disk
> > as /dev/hda, and from time to time it seems to "disappear", usually
> > after these messages appear a couple of trimes on/var/log/messages:
> 
> I get a similar problem on my Presario laptop.  In my case "all of a
> suddend" hda3 becomes write-only.  Next time it happens I'll see if I
> can capture a dmesg log or something.  It only seems to happen when I
> enable my wifi and do a lot of disk activity [but only once in a
> while].  Could be that my wifi and IDE0 share an IRQ?

I can't say the situation is the same here -- actually, it seems to be
more related (in my case) to idle times: usually this happens when the
system is under light load (or under no load at all), like between
0:00am and 6:00am. This is why my primary suspect is APM (I could be
completely wrong, of course). Also, I don't have wifi.

> Of course I'm more apt to blame my laptop than Linux since the same
> kernel [well diff build options but you know what I mean] works just
> fine on my two desktops in the house...

Yeah, I know what you mean: the same Linux distro has been running
flawlessly on other boxes around here for months (with different
hardware specs, though). Mine OTOH has a sad uptime record of 5 days...
=(

I agree Linux works (actually, it rocks =)), been using it for years
both at home and at work, but sometimes a specific hardware combination
(or buggy hardware/BIOS/firmware etc.) pushes it to the edge, reaching
some weak spots that need to be "hardened". Some hardware simply doesn't
work at all (I hope that's not my case...)

Best,

Andre

-- 
Andre Oliveira da Costa
(costa@tecgraf.puc-rio.br)
