Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315412AbSEGLjL>; Tue, 7 May 2002 07:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315413AbSEGLjK>; Tue, 7 May 2002 07:39:10 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:55312 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315412AbSEGLjJ>; Tue, 7 May 2002 07:39:09 -0400
Date: Tue, 7 May 2002 13:39:03 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 55
In-Reply-To: <3CD7A877.4050305@evision-ventures.com>
Message-ID: <Pine.LNX.4.21.0205071333210.32715-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 7 May 2002, Martin Dalecki wrote:

> > Another thing: where is the equivalilent part of this removed code?
> 
> Look closer it's there in ide-probe.c.

Does it still take the correct byte swapping into account?
Did you consider using a table for the fixup? It's nothing perfomance
critical and this might generate more compact code.

bye, Roman

