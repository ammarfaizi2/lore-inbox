Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316722AbSEQXJs>; Fri, 17 May 2002 19:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316723AbSEQXJs>; Fri, 17 May 2002 19:09:48 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:54421 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316722AbSEQXJr>; Fri, 17 May 2002 19:09:47 -0400
Date: Fri, 17 May 2002 18:09:36 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Stevie O <stevie@qrpff.net>
cc: Andrew Morton <akpm@zip.com.au>, Rusty Russell <rusty@rustcorp.com.au>,
        Ghozlane Toumi <ghoz@sympatico.ca>, <linux-kernel@vger.kernel.org>,
        <torvalds@transmeta.com>
Subject: Re: [PATCH] Fix BUG macro
In-Reply-To: <5.1.0.14.2.20020517183411.02198598@whisper.qrpff.net>
Message-ID: <Pine.LNX.4.44.0205171806110.26436-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2002, Stevie O wrote:

> What if you just let $TOPDIR = '../..' ?

It's not quite as easy (TOPDIR changes with the subdir, CFLAGS are
actually passed to sub-makes, ...), but I got a crude version working 
here. (There's actually a second way to do this more nicely, too).

Anyway, I have pending cleanups to Rules.make, which will make that change
easier too, so I'll just do it step by step.

--Kai

