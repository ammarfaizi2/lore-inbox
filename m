Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316296AbSEQQOL>; Fri, 17 May 2002 12:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316322AbSEQQOK>; Fri, 17 May 2002 12:14:10 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:52623 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316296AbSEQQOJ>; Fri, 17 May 2002 12:14:09 -0400
Date: Fri, 17 May 2002 11:14:00 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Andrew Morton <akpm@zip.com.au>, Ghozlane Toumi <ghoz@sympatico.ca>,
        <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: Re: [PATCH] Fix BUG macro 
In-Reply-To: <E178eCw-0008ML-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0205171111381.26436-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2002, Rusty Russell wrote:

> I don't care about the bloat: I care about the compile time exploding
> because every file is different in different trees, due to the
> filename strings.
> 
> It'd be very nice to have a solution to this, and I'll keep sending
> patches to Linus until he applies them or says "no do it this way".

Well, a way to work around this would be to replace

	-I$(TOPDIR)/include

with

	-I../../include

on the command line, I suppose, with the right amount of "../". A bit 
hackish, but it should do.

--Kai

