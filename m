Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276732AbRJKTVa>; Thu, 11 Oct 2001 15:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276736AbRJKTTc>; Thu, 11 Oct 2001 15:19:32 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:32402 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S276702AbRJKTS5>; Thu, 11 Oct 2001 15:18:57 -0400
Date: Thu, 11 Oct 2001 21:18:16 +0200 (CEST)
From: eduard.epi@t-online.de (Peter Bornemann)
To: Andris Pavenis <pavenis@latnet.lv>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.11: mount flag noexec still broken for VFAT partition
In-Reply-To: <Pine.LNX.4.21.0110110828290.29091-100000@gulbis.latnet.lv>
Message-ID: <Pine.LNX.4.33.0110112112530.966-100000@eduard.t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Yes I cannot really execute them (or some Linux executable if I copy it
> there). I didn't verify it earlier. Anyway I better liked behaviour of 2.2
> kernels and also 2.4 kernels up to rather recent time when
> 'ls -l' listed files as not executable (the same with mc)

Somebody on this list posted a rather clean solution: there is a
"showexec"-flag for MS-filesystems, which shows only files .exe, .com or
.bat extensions as executable. This is a better thing than to play with
umask I think. Umask will give problems with wine and (maybe) dosemu.

Best wishes

Peter B


Microsoft is not the solution, it is the problem.

