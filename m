Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSH0RIH>; Tue, 27 Aug 2002 13:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSH0RIG>; Tue, 27 Aug 2002 13:08:06 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:22033 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S316580AbSH0RIG>;
	Tue, 27 Aug 2002 13:08:06 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200208271712.g7RHCOn00898@oboe.it.uc3m.es>
Subject: Re: block device/VM question
In-Reply-To: <Pine.LNX.4.44.0208271100460.3234-100000@hawkeye.luckynet.adm> from
 Thunder from the hill at "Aug 27, 2002 11:04:23 am"
To: Thunder from the hill <thunder@lightweight.ods.org>
Date: Tue, 27 Aug 2002 19:12:24 +0200 (MET DST)
Cc: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Thunder from the hill wrote:"
> On Tue, 27 Aug 2002, Peter T. Breuer wrote:
> > You mean do a syscall with flags O_DIRECT from within the driver?
> > I don't like syscalsl from kernel code, but if you say so, I'll think
> > about it.
> 
> Not exactly, but it's a starting point. See how.

I think you're directing my attention to how to get to the inode of the
special device file. That's OK. I can get to that with no hassle. Once
there I can do whatever the sysopen with O_DIRECT does.

> <URL:ftp://ftp.es.kernel.org/pub/linux/docs/manpages/man-pages-1.53.tar.bz2>
> 
> Contains lots of the useful stuff.

I'm sure :-). But until it gets packaged for debian I don't touch :-/.

> > suggesting that it depends on the mode of access to the device? That I
> > can't control - I simply want ALL accesses to not be cached.
> 
> That's a word, and confirms the O_DIRECT interface. However, that still 
> doesn't enable me to tell you what exact implementation you'll need. Do 
> you understand my point?

Evidently not.  You must be saying that there are two possible
implementations, and that it is up to me to choose one that I like.
That's nice, but I would like to have the possibilities to choose from
in front of me! While we know schoedinger's cat may only exist or not
exist, it is only possible to say which of the two I prefer once I
have seen at least one of them :-).

Peter
