Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284762AbRLKAnc>; Mon, 10 Dec 2001 19:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284765AbRLKAnN>; Mon, 10 Dec 2001 19:43:13 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:16498 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S284762AbRLKAnF>; Mon, 10 Dec 2001 19:43:05 -0500
Date: Tue, 11 Dec 2001 01:43:46 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
Message-ID: <20011211014346.C4801@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0112101705281.25362-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0112101705281.25362-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Mon, Dec 10, 2001 at 05:08:44PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2001 at 05:08:44PM -0200, Marcelo Tosatti wrote:
> 
> Andrea, 
> 
> Could you please start looking at any 2.4 VM issues which show up ?

well, as far I can tell no VM bug should be present in my latest -aa, so
I think I'm finished. At the very least I know people is using 2.4.15aa1
and 2.4.17pre1aa1 in production on multigigabyte boxes under heavy VM
load and I didn't got any bugreport back yet.

> 
> Just please make sure that when sending a fix for something, send me _one_
> problem and a patch which fixes _that_ problem.

I will split something for you soon, at the moment I was doing some
further benchmark.

> 
> I'm tempted to look at VM, but I think I'll spend my limited time in a
> better way if I review's others people work instead.

until I split something out, you can see all the vm related changes in
the 10_vm-* patches in my ftp area.

Andrea
