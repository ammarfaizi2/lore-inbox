Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbSJaQUP>; Thu, 31 Oct 2002 11:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbSJaQUL>; Thu, 31 Oct 2002 11:20:11 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:15292 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262808AbSJaQTt>;
	Thu, 31 Oct 2002 11:19:49 -0500
Date: Thu, 31 Oct 2002 11:26:13 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Nikita Danilov <Nikita@Namesys.COM>
cc: Linus Torvalds <Torvalds@Transmeta.COM>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH]: reiser4 [8/8] reiser4 code
In-Reply-To: <15809.22155.408140.213679@laputa.namesys.com>
Message-ID: <Pine.GSO.4.21.0210311121520.16688-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 31 Oct 2002, Nikita Danilov wrote:

>  > And you want that to be reviewed until tonight?
>  > 
> 
> No. But changes to the core are not very complicated. If Linus "reviews"
> and accepts them life of reiser4 would be much simpler.

Changes to the core consist (AFAICS) of exporting a bunch of functions
with no explanation of the way they are used - with some of them it's
really straightforward (and can go in at any point), with some one
would expect really detailed explanation and code review (your comments
regarding fsync_super() export trigger all sorts of alarms for me).

PS: Cc'ing a posting on a public list to a subscribers-only one is
generally not a nice thing to do...  Cc: trimmed.

