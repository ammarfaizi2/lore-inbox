Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281505AbRKZIM1>; Mon, 26 Nov 2001 03:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281506AbRKZIMS>; Mon, 26 Nov 2001 03:12:18 -0500
Received: from hal.astr.lu.lv ([195.13.134.67]:10112 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S281505AbRKZIMG>;
	Mon, 26 Nov 2001 03:12:06 -0500
Message-Id: <200111260811.fAQ8Bw100779@hal.astr.lu.lv>
Content-Type: text/plain; charset=US-ASCII
From: Andris Pavenis <pavenis@latnet.lv>
To: ali.akcaagac@stud.fh-wilhelmshaven.de
Subject: Re: PATCH: gcc3.0.2 workaround for 8139too
Date: Mon, 26 Nov 2001 10:11:58 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem with -fomit-frame-pointer which caused gcc-3.0.X generate ICE on 
8139too.c is now fixed in gcc-3_0-branch. For example kernel 2.4.16-pre1 
builds Ok with gcc-3.0.3 20011123 (prerelease). Also 8139too.c compiles Ok 
and kernel seems to work Ok.

I have also earlier met cases when gcc-3.0.X miscompiles source (with option 
-fomit-frame-pointer only) due to same bug however it always caused crashes
of compiled source for me, not a silent data corruption.

Andris
