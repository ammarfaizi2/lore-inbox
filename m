Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbUASSOZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 13:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUASSLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 13:11:49 -0500
Received: from hoemail1.lucent.com ([192.11.226.161]:45811 "EHLO
	hoemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S262566AbUASSLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 13:11:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16395.62535.600758.816370@gargle.gargle.HOWL>
Date: Mon, 19 Jan 2004 10:14:15 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, root@chaos.analogic.com, cliffw@osdl.org,
       piggin@cyberone.com.au, mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: [1/4] better i386 CPU selection
In-Reply-To: <20040117025745.GJ12027@fs.tum.de>
References: <20040106054859.GA18208@waste.org>
	<3FFA56D6.6040808@cyberone.com.au>
	<20040106064607.GB18208@waste.org>
	<3FFA5ED3.6040000@cyberone.com.au>
	<20040110004625.GB25089@fs.tum.de>
	<20040110005232.GD25089@fs.tum.de>
	<20040116111501.70200cf3.cliffw@osdl.org>
	<Pine.LNX.4.53.0401161425110.31018@chaos>
	<20040116160133.5af17a6a.akpm@osdl.org>
	<20040117025745.GJ12027@fs.tum.de>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Adrian" == Adrian Bunk <bunk@fs.tum.de> writes:

Adrian> The main effect is that better-i386-cpu-selection.patch makes
Adrian> it easier for people who configure kernels that should work on
Adrian> different CPU types. A user (= person compiling his own
Adrian> kernel) does no longer need any deeper knowledge when
Adrian> e.g. configuring a kernel that should run on both an Athlon
Adrian> and a Pentium 4 - he simply selects all CPUs he wants to
Adrian> support in his kernel.

So a user who will only Run this kernel on a PIII for example, doesn't
need to select *any* other kernels at all?  I think the Kconfig help
screens need to be redone to make this clear.

I enabled all the sub-processors because I wanted to make sure my
kernel would boot no matter what.  It seems like I don't need that any
more, right? 

John
