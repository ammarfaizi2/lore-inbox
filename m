Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261740AbSKHLyL>; Fri, 8 Nov 2002 06:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261859AbSKHLyL>; Fri, 8 Nov 2002 06:54:11 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:9678 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261740AbSKHLyK>; Fri, 8 Nov 2002 06:54:10 -0500
Date: Fri, 8 Nov 2002 07:01:38 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Andrew Morton <akpm@digeo.com>
Cc: Jeff Dike <jdike@karaya.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-rc1 - hang with processes stuck in D
In-Reply-To: <3DC8645B.A0E99A99@digeo.com>
Message-ID: <Pine.LNX.4.44L.0211080700120.27560-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Nov 2002, Andrew Morton wrote:

> Jeff Dike wrote:
> >
> > 2.4.20-rc1 reliably gets processes stuck in D, eventually wedging the whole
> > system.  This is by diffing two kernel pools, one of which has 9 138764288
> > byte core files.
> >
> > The diff itself is stuck in __wait_on_buffer:
> >
> >         Trace; c0131608 <__wait_on_buffer+68/90>
>
> Kernel is waiting for IO completion on a read.  I would be
> suspecting your IO system, or interrupt system.

Or rather try it on a different box.

Jeff, can you please mail me privately the exact test case which produces
the problem so I can try it around here?



