Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135965AbRDVJdk>; Sun, 22 Apr 2001 05:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135999AbRDVJda>; Sun, 22 Apr 2001 05:33:30 -0400
Received: from quechua.inka.de ([212.227.14.2]:49976 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S135965AbRDVJdR>;
	Sun, 22 Apr 2001 05:33:17 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: XFree4/gdm problems with 2.4.4-pre5
In-Reply-To: <Pine.GSO.4.32.0104212250410.29571-100000@romulus.cs.ut.ee> <Pine.LNX.4.10.10104212217530.24186-100000@www.teaparty.net>
Organization: private Linux site, southern Germany
Date: Sun, 22 Apr 2001 11:12:10 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E14rFue-0003q4-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually, I have seen this symptom [albeit intermittently: may be a
> different cause] w. kernel 2.2.18/Xfree86-3 2.4.3/Xfree86-4 - gdm doesn't
> say much, except to log one message long the lines of 'client auth
> rejected' or 'connection rejected' or something like that. Haven't been

I had this problem some months ago, where XFree86 (4.0.1 IIRC) would
sometimes reject connections, giving an error message of unknown magic
cookie, under 2.4.0 but not 2.2.something. strace of the X client
shows that the cookie was in fact sent correctly.

This must have been a bug in the X server. Upgrading to 4.0.3 fixed it
(but perhaps there is a regression or it is not really fixed, only masked?)
I still have no idea what could be the cause.

Olaf
