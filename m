Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbUL3EPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUL3EPz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 23:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbUL3EPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 23:15:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:40345 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261425AbUL3EPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 23:15:53 -0500
Date: Wed, 29 Dec 2004 20:15:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Sailer <sailer@scs.ch>
Cc: torvalds@osdl.org, the3dfxdude@gmail.com, mh@codeweavers.com,
       pouech-eric@wanadoo.fr, dan@debian.org, roland@redhat.com,
       linux-kernel@vger.kernel.org, wine-devel@winehq.com
Subject: Re: ptrace single-stepping change breaks Wine
Message-Id: <20041229201531.40a0144a.akpm@osdl.org>
In-Reply-To: <1104376558.5128.22.camel@gamecube.scs.ch>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	<20041119212327.GA8121@nevyn.them.org>
	<Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org>
	<20041120214915.GA6100@tesore.ph.cox.net>
	<41A251A6.2030205@wanadoo.fr>
	<Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>
	<1101161953.13273.7.camel@littlegreen>
	<1104286459.7640.54.camel@gamecube.scs.ch>
	<1104332559.3393.16.camel@littlegreen>
	<1104348944.5645.2.camel@kronenbourg.scs.ch>
	<5304685704122912132e3f7f76@mail.gmail.com>
	<1104371395.5128.2.camel@gamecube.scs.ch>
	<Pine.LNX.4.58.0412291807440.2353@ppc970.osdl.org>
	<1104376558.5128.22.camel@gamecube.scs.ch>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Sailer <sailer@scs.ch> wrote:
>
> Another pointer towards flexible mmap is that ulimit -s unlimited makes
> it work under 2.6.10-ac1 too.
> 

You can globally disable flex-mmap with

	echo 1 > /proc/sys/vm/legacy_va_layout

Does it fix things?
