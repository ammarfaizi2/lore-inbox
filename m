Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264874AbSKEPh4>; Tue, 5 Nov 2002 10:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264873AbSKEPhz>; Tue, 5 Nov 2002 10:37:55 -0500
Received: from [198.149.18.6] ([198.149.18.6]:17631 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S264867AbSKEPhw>;
	Tue, 5 Nov 2002 10:37:52 -0500
Date: Tue, 5 Nov 2002 09:44:17 -0600
From: Nathan Straz <nstraz@sgi.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Open POSIX Test Suite
Message-ID: <20021105154417.GD2030@sgi.com>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3DC702E1.1050306@ixiacom.com> <00fd01c2845e$eb407ee0$7fd40a0a@amr.corp.intel.com> <3DC70C0C.4040004@ixiacom.com> <3DC702E1.1050306@ixiacom.com> <00fd01c2845e$eb407ee0$7fd40a0a@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC70C0C.4040004@ixiacom.com> <00fd01c2845e$eb407ee0$7fd40a0a@amr.corp.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 04:04:32PM -0800, Geoff Gustafson wrote:
> > You are about to duplicate http://ltp.sf.net
> 
> My understanding is that LTP is focused on current mainline kernel testing,
[ .. snip .. ]
> This project is concerned with the POSIX APIs regardless of where they are
> implemented (kernel, glibc, etc.). 

You are correct.  LTP isn't trying to be any kind of "compliance" test.
We're just trying to exercise and stress the Linux kernel to find bugs
and guard against regressions.

On Mon, Nov 04, 2002 at 04:08:44PM -0800, Dan Kegel wrote:
> I urge you to consider ways in which you could work within the
> framework of the LTP to meet both your goals and the LTP's goals.
> They may be more in synch than you originally thought!

I don't think LTP's "framework[1]" is going to help Geoff complete his
project.  Geoff already created a SourceForge site.  As part of the
LTP, I probably would have given him a separate CVS module and a mailing
list.  I think he has everything he needs to get started already.  

That being said, if Geoff does want his Open POSIX test suite to be part
of the LTP, we'll gladly accomodate him.  



[1] By framework I think you mean logistical, not libraries.  I think
our test libraries have some things he might like.  I just recommend
cleaning them up before using them. 
-- 
Nate Straz                                              nstraz@sgi.com
sgi, inc                                           http://www.sgi.com/
Linux Test Project                                  http://ltp.sf.net/
