Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbTAXUJL>; Fri, 24 Jan 2003 15:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265093AbTAXUJK>; Fri, 24 Jan 2003 15:09:10 -0500
Received: from ams-msg-core-1.cisco.com ([144.254.74.60]:59582 "EHLO
	ams-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S265077AbTAXUJJ>; Fri, 24 Jan 2003 15:09:09 -0500
Date: Fri, 24 Jan 2003 20:18:09 +0000
From: Derek Fawcus <dfawcus@cisco.com>
To: Kevin Lawton <kevinlawton2001@yahoo.com>
Cc: Valdis.Kletnieks@vt.edu, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Simple patches for Linux as a guest OS in a plex86 VM (please consider)
Message-ID: <20030124201808.E14343@edinburgh.cisco.com>
References: <200301241901.h0OJ1j0V005436@turing-police.cc.vt.edu> <20030124190917.37534.qmail@web80301.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20030124190917.37534.qmail@web80301.mail.yahoo.com>; from kevinlawton2001@yahoo.com on Fri, Jan 24, 2003 at 11:09:17AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2003 at 11:09:17AM -0800, Kevin Lawton wrote:
> --- Valdis.Kletnieks@vt.edu wrote:
> 
> > It turns out that the 99% of the work to cover the 1% of the cases is really
> > important.  The usual reason for doing VM is to isolate images from each
> > other
> 
> Plex86 can 100% isolate guests from each other.  What I'm saying
> is, it takes 99% of the work to do a full x86 VM which doesn't
> need those 2 macros for PUSHF/POPF.  (my oversimplified, but
> yet useful explanation of the state of affairs)
> 
> You have to do a lot of work to "get under the hood" of an
> OS, to fix up a few cases where if you let them run native,
> they'll get the wrong information or make the wrong thing
> happen.  Not to the other guests, but to themselves.  So if
> you don't need to do those things, you can let them run
> without all the black magic.  Let's take such conversation
> out-of-band.  It doesn't belong on the LK list.

Well actually I find it quite interesting...

One thing that seems to have been alluded to but not explicity stated
is just where is this patch going, and what affect will happen when
running a non 'VM friendly' OS under the 'new plex86'.

One thing that I'm curious about is how say thing'd work when running
a linux host, with a VM-friendly linux client,  and say a Win-2k
client.

I assume that the Win-2k client woudl end up having to trap to a
simulator (bochs) for it's ring 0 stuff.  But would things in the
above scenario work nicely,  with proper isolation between the
two (or more) clients?

DF
