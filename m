Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314835AbSF3ML6>; Sun, 30 Jun 2002 08:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314885AbSF3ML5>; Sun, 30 Jun 2002 08:11:57 -0400
Received: from [193.14.93.89] ([193.14.93.89]:30980 "HELO acolyte.hack.org")
	by vger.kernel.org with SMTP id <S314835AbSF3ML5>;
	Sun, 30 Jun 2002 08:11:57 -0400
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Can't find watchdog timer (sc1200)
References: <200206271803.11350.roy@karlsbakk.net>
	<m36601827v.fsf@acolyte.hack.org>
	<200206301328.23850.roy@karlsbakk.net>
From: Christer Weinigel <wingel@acolyte.hack.org>
Date: 30 Jun 2002 14:14:10 +0200
In-Reply-To: Roy Sigurd Karlsbakk's message of "Sun, 30 Jun 2002 13:28:23 +0200"
Message-ID: <m3znxd6k19.fsf@acolyte.hack.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk <roy@karlsbakk.net> writes:
> On Sunday 30 June 2002 12:56, Christer Weinigel wrote:
> > I'm not all that sure if that driver works on the sc1200 because that
> > driver tries to talk to the watchdog in the SuperI/O chip and that
> > chip has another watchdog circuit too.  I've written a driver for the
> > other watchdog chip, so if you can, please try this patch against a
> > 2.4.9-pre10 kernel:
> 
> I guess that'll be 2.4.19-pre10? :-)

Correct, my bad.

I've been reading the data sheets for the SC2200 and it seems as if
the watchdog is gone from the integrated SuperI/O, so you should use
my driver instead.  Zwane Mwaikambo's driver ought to work on the
NatSemi PC97317 SuperI/O.  Hm, I think I have some hardware that I
should be able to test that on.

Oh well, I think I'll just submit my driver to Marcelo and see what
happens.  I've cleaned up the driver a bit since the last time I
tried.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"
