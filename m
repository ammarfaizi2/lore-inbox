Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261720AbSIXRl3>; Tue, 24 Sep 2002 13:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261752AbSIXRkw>; Tue, 24 Sep 2002 13:40:52 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:22912 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261720AbSIXRYd>; Tue, 24 Sep 2002 13:24:33 -0400
Date: Tue, 24 Sep 2002 14:29:30 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Mark Veltzer <mark@veltzer.org>
Cc: Peter Svensson <petersv@psv.nu>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Offtopic: (was Re: [ANNOUNCE] Native POSIX Thread Library 0.1)
In-Reply-To: <200209241519.g8OFJcB26734@www.veltzer.org>
Message-ID: <Pine.LNX.4.44L.0209241427520.15154-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2002, Mark Veltzer wrote:
> On Tuesday 24 September 2002 17:50, Peter Svensson wrote:
> > Either you need to educate your users and trust them to
> > behave, or you need per user scheduling.
>
> It is obvious that in high end systems you MUST have per user scheduling
> since users will rob each other of cycles.... If Linux is to be a
> general purpose operation system it MUST have this feature

I just posted a patch for this and will upload the patch to
my home page:

Subject: [PATCH] per user scheduling for 2.4.19


My patch also allows you to switch the per user scheduling
on/off with /proc/sys/kernel/fairsched and has been tested
on both UP and SMP.

kind regards,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/


