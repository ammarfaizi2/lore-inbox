Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266998AbTCEBKv>; Tue, 4 Mar 2003 20:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267013AbTCEBKu>; Tue, 4 Mar 2003 20:10:50 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:37901 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266998AbTCEBKt>; Tue, 4 Mar 2003 20:10:49 -0500
Date: Wed, 5 Mar 2003 02:21:12 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Sam Ravnborg <sam@ravnborg.org>
cc: Erlend Aasland <erlend-a@ux.his.no>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5][RFC] Make mconf inform user about supported make
 targets
In-Reply-To: <20030304191311.GB1917@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0303050219250.1336-100000@serv>
References: <20030304113054.GA29401@badne3.ux.his.no> <20030304191311.GB1917@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 4 Mar 2003, Sam Ravnborg wrote:

> > Solution: Get mconf to tell the user about arch-specific targets,
> > instead of i386 targets.
> 
> I see no need for this patch.
> Most architectures today (if not all) has a sensible default target.
> 
> So changing mconf to print something like:
> "Next, you may run 'make' to build your kernel."
> 
> Should be a good enough guide for the user.

I agree and actually I'd like to remove that message completely from the 
config tools. It's the job of kbuild to tell the user what to do next.

bye, Roman

