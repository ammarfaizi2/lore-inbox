Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270832AbTHARQl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 13:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270833AbTHARQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 13:16:41 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:51975 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S270832AbTHARQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 13:16:40 -0400
Date: Fri, 1 Aug 2003 19:16:37 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Nico Schottelius <nico-kernel@schottelius.org>
Cc: Steve Lord <lord@sgi.com>, scholz@wdt.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bug in 2.6.0test2
Message-ID: <20030801171637.GB3343@win.tue.nl>
References: <20030728115902.GA18993@schottelius.org> <1059425249.6601.10.camel@jen.americas.sgi.com> <20030728222641.GE10741@schottelius.org> <1059478999.1749.18.camel@laptop.americas.sgi.com> <20030731111418.GJ264@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731111418.GJ264@schottelius.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 01:14:18PM +0200, Nico Schottelius wrote:

> ...we tried and experiment some more, here the results:
>    - first we had old modutils (now: module-init-tools 0.9.13pre)
>    - all modules are able to load now (loaded: aes,loop,cryptoloop)
>    - losetup -e aes /dev/hda1 /dev/loop0 
>       --> ioctl: LOOP_SET_FD: invalid argument

You interchange the parameters. Call is
	losetup [options] loop_device file

