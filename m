Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264497AbTLGUUw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 15:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264504AbTLGUUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 15:20:52 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:7296 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264497AbTLGUUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:20:46 -0500
Date: Sun, 7 Dec 2003 15:19:48 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: sean darcy <seandarcy@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 260t11-bk4 problem -- hung processes
In-Reply-To: <3FD388F0.3070205@hotmail.com>
Message-ID: <Pine.LNX.4.58.0312071519090.1758@montezuma.fsmlabs.com>
References: <200312062254.RAA26015@clem.clem-digital.net.lucky.linux.kernel>
 <3FD388F0.3070205@hotmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Dec 2003, sean darcy wrote:

> Pete Clements wrote:
> > With 2.6.0-t11-bk4, mozilla hangs before it can come up.
> > At this point other processes that touch the associated
> > /proc entries hang also (such as a ps). Can not kill the
> > process. Shutdown also hangs.
> >
> > Everything fine with bk3.
> >
>
> Same here.
>
> I can run top. But as soon as I try to start mozilla, top freezes. Other
> odd processes hang: the shutdown script for cups hangs; uic from qt
> hangs; startkde hangs ( good thing gnome works! ).
>
> bk3 also works for me. From the bk4 changelog, not clear whats the problem

It got fixed, wait for the next snapshot.

ChangeSet 1.1512 2003/12/06 14:34:40 torvalds@home.osdl.org
  Fix the PROT_EXEC breakage on anonymous mmap.

  Clean up the tests while at it.
mm/mmap.c 1.95 2003/12/06 14:34:36 torvalds@home.osdl.org
  Fix PROT_EXEC breakage on anonymous mmap.
