Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267159AbTA0LQn>; Mon, 27 Jan 2003 06:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267157AbTA0LQn>; Mon, 27 Jan 2003 06:16:43 -0500
Received: from mail5.home.nl ([213.51.128.16]:16887 "EHLO mail5-sh.home.nl")
	by vger.kernel.org with ESMTP id <S267159AbTA0LQm>;
	Mon, 27 Jan 2003 06:16:42 -0500
Subject: Re: 2.5.59-mm6
From: Luuk van der Duim <l.a.van.der.duim@student.rug.nl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1043670419.1691.30.camel@cc75757-a.groni1.gr.home.nl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1-1mdk 
Date: 27 Jan 2003 13:27:00 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello mm-users,


  . The mysterious "machine hangs late in boot" problem has been narrowed
    down thanks to some great work by Andres Salomon.  The machine is stuck
    waiting on I/O completion when performing the initial lookup for
    /sbin/devfs_helper:


I don't believe it to be an exclusively small-devfs helper problem.

It is an interaction at best. Sure I had problems using devfs-small, but
mm2 worked and mm3 was the first that halted during boot. Both have
devfs-small, and both need its helper. Or I am missing a subtlety here?

Secondly, Andrew sent me a rollup of patches against 2.5.59 he thought
were suspicious, without smalldevfs and it also halted, but at another
place in boot, at adding swap.

Can someone besides me confirm this behavior or am I the loon who just
won't understand?

Luuk

 



