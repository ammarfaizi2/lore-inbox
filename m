Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264702AbSKDPFT>; Mon, 4 Nov 2002 10:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264701AbSKDPFT>; Mon, 4 Nov 2002 10:05:19 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:29840 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264699AbSKDPFT>; Mon, 4 Nov 2002 10:05:19 -0500
Subject: Re: Filesystem Capabilities in 2.6?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       Dax Kelson <dax@gurulabs.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, davej@suse.de
In-Reply-To: <20021104145049.GC9197@think.thunk.org>
References: <87y98bxygd.fsf@goat.bogus.local>
	<Pine.LNX.4.44.0211021754180.2300-100000@home.transmeta.com>
	<20021104024910.GA14849@ravel.coda.cs.cmu.edu> 
	<20021104145049.GC9197@think.thunk.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Nov 2002 15:33:25 +0000
Message-Id: <1036424005.1113.73.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-04 at 14:50, Theodore Ts'o wrote:
> This sounds like the right way to go.  I do hope the configuration
> file includes an SHA checksum of the secutable.  And to avoid race
> conditions, there really ought to be a new system call, fexecve(2)
> which takes an open file descriptor instead of a pathname.
> (Unfortunately, we're in feature freeze now, so that will have to wait
> until 2.7.)

execve /proc/self/fd/n ???


