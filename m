Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270328AbTHBStK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 14:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270332AbTHBStK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 14:49:10 -0400
Received: from holomorphy.com ([66.224.33.161]:38884 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S270328AbTHBStI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 14:49:08 -0400
Date: Sat, 2 Aug 2003 11:50:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Piotr Kierklo <P.Kierklo@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: My kernel hangs once a day
Message-ID: <20030802185017.GB32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Piotr Kierklo <P.Kierklo@elka.pw.edu.pl>,
	linux-kernel@vger.kernel.org
References: <Pine.SOL.4.30.0308022029410.20976-101000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0308022029410.20976-101000@mion.elka.pw.edu.pl>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 08:38:49PM +0200, Piotr Kierklo wrote:
> Finally I have decided to submit my kernel oopses I have been
> experiencing. It became annoying since i switched to use Linux as my
> primary OS. They happen average once a day. I am not sure whether it is an
> ext3 bug or memory problems, so I am sending them to this address I have
> found in Documentation dir of kernel tree.
> I am using Slackware linux with 2.4.21 kernel:
> Linux repetus 2.4.21-ow2 #14 sob sie 2 17:07:14 CEST 2003 i686 unknown
> unknown GNU/Linux
> Kernel is tainted, as I am using NVIDIA graphics driver to run my X11.
> Bugs happen both in text as in graphical mode. Most of them are somewhat
> connected to kswapd, as it is the most frequent phrase I observed in them.
> Please contact if you need more info.

Unfortunately the nvidia bits are a showstopper; we just can't know
anything about the internals like we do for un-tainted kernels, so
you have to go to nvidia about such things.

Alternatively, if you can reproduce it while the kernel is untainted
(without nvidia) then we can get an idea of what might be going on.


-- wli
