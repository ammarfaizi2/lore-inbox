Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbTAXTAK>; Fri, 24 Jan 2003 14:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbTAXTAK>; Fri, 24 Jan 2003 14:00:10 -0500
Received: from web80301.mail.yahoo.com ([66.218.79.17]:22458 "HELO
	web80301.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261733AbTAXTAJ>; Fri, 24 Jan 2003 14:00:09 -0500
Message-ID: <20030124190917.37534.qmail@web80301.mail.yahoo.com>
Date: Fri, 24 Jan 2003 11:09:17 -0800 (PST)
From: Kevin Lawton <kevinlawton2001@yahoo.com>
Subject: Re: Simple patches for Linux as a guest OS in a plex86 VM (please consider) 
To: Valdis.Kletnieks@vt.edu
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <200301241901.h0OJ1j0V005436@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Valdis.Kletnieks@vt.edu wrote:

> It turns out that the 99% of the work to cover the 1% of the cases is really
> important.  The usual reason for doing VM is to isolate images from each
> other

Plex86 can 100% isolate guests from each other.  What I'm saying
is, it takes 99% of the work to do a full x86 VM which doesn't
need those 2 macros for PUSHF/POPF.  (my oversimplified, but
yet useful explanation of the state of affairs)

You have to do a lot of work to "get under the hood" of an
OS, to fix up a few cases where if you let them run native,
they'll get the wrong information or make the wrong thing
happen.  Not to the other guests, but to themselves.  So if
you don't need to do those things, you can let them run
without all the black magic.  Let's take such conversation
out-of-band.  It doesn't belong on the LK list.

-Kevin

__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
