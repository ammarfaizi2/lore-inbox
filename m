Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbULBRwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbULBRwu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 12:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbULBRwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 12:52:18 -0500
Received: from adsl.a2000.nu ([80.126.253.168]:20359 "EHLO adsl.a2000.nu")
	by vger.kernel.org with ESMTP id S261675AbULBRvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 12:51:10 -0500
Date: Thu, 2 Dec 2004 18:51:01 +0100 (CET)
From: Stephan van Hienen <kernel@a2000.nu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: nfs and LBD support (2TB+)
In-Reply-To: <1101945033.32266.33.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.61.0412021850120.16787@adsl.a2000.nu>
References: <Pine.LNX.4.61.0412020017550.2774@adsl.a2000.nu>
 <1101945033.32266.33.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2004, Trond Myklebust wrote:

> Yep... There is a slight problem with the way glibc has decided to
> implement the statvfs function when interacting with 2.6.x kernels...
>

<..>

> This was not a problem in Linux-2.4.x, 'cos glibc would simply emulate a
> value for f_frsize by setting it to f_bsize.
> However for 2.6.x kernels, glibc grabs a value of f_frsize that the
> kernel gives it. So if that value differs from the bsize (and allowing
> f_frsize != f_bsize is the whole point of passing a value for f_frsize
> to glibc in the first place), you get wierd discrepancies like the
> above.

and is there a fix ?
(it looks like it's working ok, but still i would like to see the actual 
free space/usage)
