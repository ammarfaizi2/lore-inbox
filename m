Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbUCCW4y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 17:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUCCW4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 17:56:53 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:25085 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261221AbUCCW4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 17:56:52 -0500
Subject: Re: [Kgdb-bugreport] [KGDB PATCH][1/7] Add / use
	kernel/Kconfig.kgdb
From: Jim Houston <jim.houston@comcast.net>
Reply-To: jim.houston@comcast.net
To: George Anzinger <george@mvista.com>
Cc: amitkale@emsyssoft.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1078354486.1824.363.camel@new.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 03 Mar 2004 17:54:46 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Meanwhile, I would like to make a change to the gdb "info thread"
> command to do a better job of displaying the threads.  Here is what
> I am proposing:
> 
> Gdb would work as it does now if the following set is not done.
> 
> A new "set thread_level" command that would take the "bt" level to use
> on the thread display.
> A new "set thread_limits command that would take two expressions that
> would reduce to two memory addresses.

Hi George,

I already did a bit of work in this space.  You might give my 
gdb-thread-skip-frame.patch a try.  

You can find it archived here:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/gdb/gdb-6.0/gdb-thread-skip-frame.patch

Jim Houston

