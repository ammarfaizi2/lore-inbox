Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbTJNVJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 17:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262801AbTJNVJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 17:09:29 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:24192 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S262776AbTJNVJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 17:09:24 -0400
Date: Tue, 14 Oct 2003 23:09:23 +0200
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Vortex full-duplex doesn't work?
Message-ID: <20031014230923.D2935@beton.cybernet.src>
References: <20031014223109.A7167@beton.cybernet.src> <20031014140216.21cf33a3.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031014140216.21cf33a3.rddunlap@osdl.org>; from rddunlap@osdl.org on Tue, Oct 14, 2003 at 02:02:16PM -0700
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> | Hello
> | 
> | I have collected from tidbits of information that
> | ether=0,0,0x201,0,eth0 should set my 3c900 card to full duplex AUI.
> | 
> | I have tried this, then ifconfig eth0 up and then
> | vortex-diag -vv and it still reports MAC Settings: half-duplex
> | 
> | When I rewrite all occurences of full_duplex in 3c59x.c for hard-coded
> | "1", then I get MAC Settings: full-duplex
> | 
> | How do I set up this driver to force full-duplex AUI for 3c900 network
> | card without using modules and without patching 3c59x.c?
> 
> BTW, what kernel version ???

2.4.22

> As I indicated in another reply to you, <quote>
> Please try this, although I'm not yet convinced that the 3c59x
> driver calls all of the right hooks for this to work.
> but good luck, and please report back on it. </quote>

So the only possibility apart from introducing modules is hacking it up in the
driver? I tried the 3Com setup DOS diskette and it refuses to set full duplex
together with AUI.

Cl<
