Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318895AbSHMBGK>; Mon, 12 Aug 2002 21:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318896AbSHMBGK>; Mon, 12 Aug 2002 21:06:10 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:29197 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318895AbSHMBGK>; Mon, 12 Aug 2002 21:06:10 -0400
Date: Mon, 12 Aug 2002 22:09:41 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Thomas Molina <tmolina@cox.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: pte_chain leak in rmap code (2.5.31)
In-Reply-To: <Pine.LNX.4.44.0208121942371.25611-100000@dad.molina>
Message-ID: <Pine.LNX.4.44L.0208122208510.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2002, Thomas Molina wrote:
> On Mon, 12 Aug 2002, Rik van Riel wrote:
> > On Mon, 12 Aug 2002, Christian Ehrhardt wrote:
> >
> > > Note the strange use of continue and break which both achieve the same!
> > > What was meant to happen (judging from rmap-13c) is that we break
> > Excellent hunting!   Thank you!
> Any chance this is the cause of the following?

Yes, quite possible.

> From:     Adam Kropelin <akropel1@rochester.rr.com>
> Date:     2002-08-12 2:54:31

> But we do have a repeatable inconsistency happening with ntpd and
> memory pressure.  That may be related, but in that case it's probably
> related to mlock().

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

