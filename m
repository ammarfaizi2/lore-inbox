Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286968AbSA3AHE>; Tue, 29 Jan 2002 19:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287401AbSA3AGs>; Tue, 29 Jan 2002 19:06:48 -0500
Received: from www.transvirtual.com ([206.14.214.140]:17679 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S287254AbSA3AFe>; Tue, 29 Jan 2002 19:05:34 -0500
Date: Tue, 29 Jan 2002 16:05:21 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Pozsar Balazs <pozsy@sch.bme.hu>
cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.2-dj7
In-Reply-To: <Pine.GSO.4.30.0201300047200.940-100000@balu>
Message-ID: <Pine.LNX.4.10.10201291602510.29648-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >  > > 2.5.2-dj7
> >  > > o   Workaround some broken PS/2 mice.			(Vojtech Pavlik)
> >  > What is this about exactly?
> >
> >  Some PS2 mice forget to ACK the GetID command before sending
> >  a response.
> 
> I just asked, because sometimes gpm can lock up my keyboard if it cannot
> read psaux. (it's 2.4) Might it be related?

Have you tried the DJ tree with the new input devices to see if you still
have this problem?


P.S
   In dmi_scan.c this is a hook to deal with the PS/2 mouse on Dell
Latitude C600. Can someone with this machine test the new input drivers on
it. I like to see if we need some kind of fix for this device.

