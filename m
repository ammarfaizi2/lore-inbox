Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261566AbSJ1WIl>; Mon, 28 Oct 2002 17:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261567AbSJ1WIk>; Mon, 28 Oct 2002 17:08:40 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:53515 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261566AbSJ1WIE>; Mon, 28 Oct 2002 17:08:04 -0500
Date: Mon, 28 Oct 2002 17:13:22 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.44-ac5
In-Reply-To: <20021028181858.GA1245@mars.ravnborg.org>
Message-ID: <Pine.LNX.3.96.1021028171110.2419A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, Sam Ravnborg wrote:

> The only difference between the PCMIA version and the normal one is
> small details with respect to interrupts.
> I wonder if that could be configured during startup of the driver, hereby
> selecting between normal or PCMIA version.
> But i have never written a Linux driver so my knowledge in this area is
> too low to judge.

The thing to avoid is a "configure" which fails if there are both PCI and
PCMCIA devices which use the same driver. I don't know if that's possible
here, I'm simply sharing the caveat in case you move forward with any
solution.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

