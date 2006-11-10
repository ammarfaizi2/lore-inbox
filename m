Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424453AbWKJWTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424453AbWKJWTx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 17:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424454AbWKJWTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 17:19:53 -0500
Received: from bay0-omc2-s8.bay0.hotmail.com ([65.54.246.144]:4073 "EHLO
	bay0-omc2-s8.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1424453AbWKJWTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 17:19:52 -0500
Message-ID: <BAY105-F3174201F15A16C2B73C18AA3F70@phx.gbl>
X-Originating-IP: [82.226.72.184]
X-Originating-Email: [tobiasoed@hotmail.com]
In-Reply-To: <20061110214835.GA8017@elf.ucw.cz>
From: "Tobias Oed" <tobiasoed@hotmail.com>
To: pavel@ucw.cz
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com
Subject: Re: pdc202xx_old+suspend+smartctl -> hard lockup
Date: Fri, 10 Nov 2006 17:19:51 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 10 Nov 2006 22:19:52.0158 (UTC) FILETIME=[57AACFE0:01C70516]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi!
>
> > Hello, if I run
> > smartctl -s on /dev/hde
> > after suspending my machine to ram (echo mem > /sys/power/state), it 
>locks
> > up with nothing on serial console, and no sysrq.
> > If I move hde to hdd, I don't have the problem, so I suspect the problem
> > comes from my (on board) pdc20265 ide controller and not the drive.
> > This is a fc6 system running a vanilla 2.6.18 kernel (the fc kernels 
>have
> > the same issue) and smartd disabled.
>
>Does suspend-to-disk work on same machine?
>									Pavel

Both suspend to disk and standby survive the smartctl -s on /dev/hde. It's 
only after resuming from suspend to ram that smartctl will hang the box.
Tobias.

_________________________________________________________________
Stay in touch with old friends and meet new ones with Windows Live Spaces 
http://clk.atdmt.com/MSN/go/msnnkwsp0070000001msn/direct/01/?href=http://spaces.live.com/spacesapi.aspx?wx_action=create&wx_url=/friends.aspx&mkt=en-us

