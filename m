Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314643AbSEDQ3T>; Sat, 4 May 2002 12:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314681AbSEDQ3S>; Sat, 4 May 2002 12:29:18 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:41994 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S314643AbSEDQ3R>; Sat, 4 May 2002 12:29:17 -0400
Date: Sat, 4 May 2002 18:29:02 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: rddunlap@osdl.org
Cc: Keith Owens <kaos@ocs.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 release 2.4
Message-ID: <20020504162902.GB21542@louise.pinerecords.com>
In-Reply-To: <20020504121529.GA20335@louise.pinerecords.com> <Pine.LNX.4.33.0205040918450.22716-100000@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 12 days, 10:22)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> | Hmm, I don't think this analogy will do -- working with aliases involving
> | fileutils as root is a way straight to hell, and hardly anyone ever walks
> | it. With kbuild-2.5, however, I have to set $KBUILD_OBJTREE every time
> | I want to build a kernel with objects out of the source dir -- and hey,
> | is there a single person on this list who's never made a typo on the
> | command line?
> |
> | I don't know how to properly emphasize that this *is* asking for problems,
> | but still I'd be surprised if I were the only one scared by files not
> | connected to the build getting erased on make mrproper. Hello, anyone? :)
> 
> Too much policy here?
> 
> | Would it be complicated to only kill the files the build knows it had
> | created?
> 
> That's what I would expect.


Word. The purpose of all the 'clean' targets in Makefiles (distclean,
mrproper, etc.) everywhere has always been to get rid of the object/
build files, and the object/build files only.

Don't get me wrong, Keith, I believe kbuild 2.5's a terrific piece of
code, I'm just discussing what I've found myself to be in trouble with.


T.
