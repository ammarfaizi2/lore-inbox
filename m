Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVA1LW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVA1LW2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 06:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVA1LW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 06:22:27 -0500
Received: from styx.suse.cz ([82.119.242.94]:23205 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261285AbVA1LWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 06:22:25 -0500
Date: Fri, 28 Jan 2005 12:10:05 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: Possible bug in keyboard.c (2.6.10)
Message-ID: <20050128111005.GA9232@ucw.cz>
References: <Pine.LNX.4.61.0501270318290.4545@82.117.197.34> <20050127125637.GA6010@pclin040.win.tue.nl> <Pine.LNX.4.61.0501272248380.6118@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501272248380.6118@scrub.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 01:39:08AM +0100, Roman Zippel wrote:

> On Thu, 27 Jan 2005, Andries Brouwer wrote:
> 
> > In short - raw mode in 2.6 is badly broken.
 
And, btw, raw mode in 2.6 is not badly broken. It works as it is
intended to. If you want the 2.4 behavior on x86, you just need to
specify "atkbd.softraw=0" on the kernel command line.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
