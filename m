Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270020AbUJNKAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270020AbUJNKAv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 06:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270019AbUJNKAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 06:00:51 -0400
Received: from defender.easycracker.org ([217.160.180.132]:35277 "HELO
	s-und-t-linnich.de") by vger.kernel.org with SMTP id S270020AbUJNKAj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 06:00:39 -0400
Date: Thu, 14 Oct 2004 14:02:01 +0200
From: "mobil@wodkahexe.de" <mobil@wodkahexe.de>
To: Wil Reichert <wil.reichert@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4 Wrong processor speed
Message-Id: <20041014140201.12830c5a.mobil@wodkahexe.de>
In-Reply-To: <7a329d9104101211077e97ee33@mail.gmail.com>
References: <20041012200402.765b2231.mobil@wodkahexe.de>
	<7a329d9104101211077e97ee33@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2004 18:07:09 +0000
Wil Reichert <wil.reichert@gmail.com> wrote:

> Just the current speed its running at, M's can drop the CPU to 600MHz
> to save power.  Were the boots with the machine plugged or unplugged? 
> I've noticed they'll start at the slower speed unplugged.  Something
> like cpudyn makes boot speed irrelevant anyway.
> 
> Wil
> 
> On Tue, 12 Oct 2004 20:04:02 +0200, mobil@wodkahexe.de
> <mobil@wodkahexe.de> wrote:
> > Hi,
> > 
> > there seems to be some problem with detecting/displaying processor
> > speed.
> > 
> > 2.6.8.1: Detected 1399.199 MHz processor
> > 2.6.9-rc3: Detected 599.541 MHz processor
> > 2.6.9-rc4: Detected 599.542 MHz processor
> > 
> > Machine is an Acer Travelmate 291lci laptop. (Pentium M - centrino - speedstep)
> > This machine is running at 600Mhz, if it does not need more power.
> > But it should display the real clockspeed at bootup, shouldn't it ?
> > 
> > Regards, Sebastian
> > 
> > 
> >
> 

Hi,

when booting with ac adapter plugged in, i get "1399.199 MHz", when unplugged "599.541 MHz".
Seems, you're right.

So it's just an cosmetic issue.

Regards, Sebastian
