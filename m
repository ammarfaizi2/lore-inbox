Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUF0Lko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUF0Lko (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 07:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUF0Lko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 07:40:44 -0400
Received: from [80.72.36.106] ([80.72.36.106]:32428 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S262006AbUF0Lkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 07:40:42 -0400
Date: Sun, 27 Jun 2004 13:40:37 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: Wes Janzen <superchkn@sbcglobal.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Pauli Virtanen <pauli.virtanen@hut.fi>
Subject: Re: [PATCH] Staircase scheduler v7.4
In-Reply-To: <Pine.LNX.4.58.0406271915440.29181@kolivas.org>
Message-ID: <Pine.LNX.4.58.0406271337290.8480@alpha.polcom.net>
References: <40DC38D0.9070905@kolivas.org> <40DDD6CC.7000201@sbcglobal.net>
 <Pine.LNX.4.58.0406271915440.29181@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jun 2004, Con Kolivas wrote:

> On Sat, 26 Jun 2004, Wes Janzen wrote:
> 
> > I don't know what's going on but 2.6.7-mm2 with the staircase v7.4 (with 
> > or without staircase7.4-1) takes about 3 hours to get from loading the 
> > kernel from grub to the login prompt.  Now I realize my K6-2 400 isn't 
> > state of the art...  I don't have this problem running 2.6.7-mm2.
> > 
> > It just pauses after starting nearly every service for an extended 
> > period of time.  It responds to sys-rq keys but just seems to be doing 
> > nothing while waiting.
> 
> Same problem as the rest I'm sure. I'm looking into it. Thanks for report.

I have this problem since 2.6.7-ck1. I use Gentoo (with paralell rc 
scripts). For me it hangs somewhere in hotpluging (hotplug+udev). As a 
workaround I press SysRQ-P ("Show regs") several times and it does help.


Grzegorz Kulewski

