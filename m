Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266760AbSKZTwV>; Tue, 26 Nov 2002 14:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266761AbSKZTwV>; Tue, 26 Nov 2002 14:52:21 -0500
Received: from isp247n.hispeed.ch ([62.2.95.247]:54960 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id <S266760AbSKZTwU>;
	Tue, 26 Nov 2002 14:52:20 -0500
To: linux-kernel@vger.kernel.org
In-Reply-To: <200211261935.03674.bhards@bigpond.net.au>
Subject: Re: A Kernel Configuration Tale of Woe
From: otto.wyss@bluewin.ch (Otto Wyss)
Date: Tue, 26 Nov 2002 20:59:37 +0100
Message-ID: <1fm9ur7.1cv4r4x15rw2waM%otto.wyss@bluewin.ch>
User-Agent: MacSOUP/D-2.4.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > goodies to autodetect what hardware driver options are appropriate for
> > your system, based on contents of various bits of /proc.  i haven't
> > heard anything about it in quite some time but it sure seems like this
> > would be the most appropriate tool for cases like yours.
> Giacomo Catenazzi is the author.
> It copped some of the CML2 fallout. See
> http://sourceforge.net/projects/kautoconfigure/
> 
Not very much at the website, 
do you know its state and if it is included in kernel 2.5?

IMO each driver should be able (within resonable limits) to detect the
hardware it is written for, returning a simple true/false. This way any
driver could be asked if its hardware is available. With trial and error
it should be possible to autodetect any hardware. This way there is no
need for a centralize database. Of course if there is no driver one
could ask that hardware never gets detected.

O. Wyss
