Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbUAYAK7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 19:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUAYAK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 19:10:59 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:32140 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263568AbUAYAKz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 19:10:55 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 24 Jan 2004 16:10:56 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Valdis.Kletnieks@vt.edu
cc: Andrew Morton <akpm@osdl.org>, Felix von Leitner <felix-kernel@fefe.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Request: I/O request recording 
In-Reply-To: <200401250004.i0P04mx8005321@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.44.0401241609470.14163-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jan 2004 Valdis.Kletnieks@vt.edu wrote:

> On Sat, 24 Jan 2004 15:53:44 PST, Davide Libenzi said:
> 
> > > Anyway, the code's ancient but might provide some ideas:
> > > 
> > > 	http://www.zip.com.au/~akpm/linux/fboot.tar.gz
> > 
> > Warning. I don't know if they do have a patent for this, but MS does this 
> > starting from XP (look inside %WINDIR%\PreFetch). It is both boot and app 
> > based.
> 
> Hmm.. prior art time. ;)
> 
> IBM's OS/VS1 and MVS operating systems had the 'link pack area', where
> frequently loaded modules were loaded at system startup.  And there were
> numerous 3rd party optimizers that would analyze the LOAD SVC patterns on your
> system and produce a list of which modules should be pre-loaded in order to get
> the most bang for the buck (even a *large* 370/168 or 303x processor might be
> able to spare a megabyte tops, so optimizing it was important, and sites would
> spend $5K on software that would optimize the memory usage and save them a
> memory upgrade at $40K a meg...
> 
> This was mid-70s, so definitely pre-XP.

They (MS) do work of a page fault basis though. It is quite different.



- Davide


