Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162162AbWKPCCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162162AbWKPCCX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162164AbWKPCCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:02:23 -0500
Received: from bay0-omc3-s30.bay0.hotmail.com ([65.54.246.230]:7202 "EHLO
	bay0-omc3-s30.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1162163AbWKPCCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:02:22 -0500
Message-ID: <BAY105-F38AC388809CE93294ABBE2A3E90@phx.gbl>
X-Originating-IP: [82.226.72.184]
X-Originating-Email: [tobiasoed@hotmail.com]
From: "Tobias Oed" <tobiasoed@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, B.Zolnierkiewicz@elka.pw.edu.pl, pavel@ucw.cz
Subject: re: pdc202xx_old+suspend+smartctl -> hard lockup
Date: Wed, 15 Nov 2006 21:02:21 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 16 Nov 2006 02:02:22.0115 (UTC) FILETIME=[40ED5730:01C70923]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Hi!
> >
> > > Hello, if I run
> > > smartctl -s on /dev/hde
> > > after suspending my machine to ram (echo mem > /sys/power/state), it 
> >locks
> > > up with nothing on serial console, and no sysrq.
> > > If I move hde to hdd, I don't have the problem, so I suspect the 
>problem
> > > comes from my (on board) pdc20265 ide controller and not the drive.
> > > This is a fc6 system running a vanilla 2.6.18 kernel (the fc kernels 
> >have
> > > the same issue) and smartd disabled.
> >
> >Does suspend-to-disk work on same machine?
> >                                                                       
>Pavel
>
>Both suspend to disk and standby survive the smartctl -s on /dev/hde. It's 
>only after resuming from suspend to ram that smartctl will hang the box.
>Tobias.

Quick note to report that this problem is gone with 2.6.19-rc5
Thanks for a great kernel!
Tobias

_________________________________________________________________
Share your latest news with your friends with the Windows Live Spaces 
friends module. 
http://clk.atdmt.com/MSN/go/msnnkwsp0070000001msn/direct/01/?href=http://spaces.live.com/spacesapi.aspx?wx_action=create&wx_url=/friends.aspx&mk

