Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUCWJ6t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 04:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbUCWJ6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 04:58:49 -0500
Received: from 194.149.109.108.adsl.nextra.cz ([194.149.109.108]:9695 "EHLO
	gate2.perex.cz") by vger.kernel.org with ESMTP id S262418AbUCWJ6r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 04:58:47 -0500
Date: Tue, 23 Mar 2004 10:58:09 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: caszonyi@rdslink.ro
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops with alsa (oss emulation)
In-Reply-To: <Pine.LNX.4.53.0403222329290.453@grinch.ro>
Message-ID: <Pine.LNX.4.58.0403231056240.2186@pnote.perex-int.cz>
References: <Pine.LNX.4.53.0403222329290.453@grinch.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004 caszonyi@rdslink.ro wrote:

> Hi
> 
> when i run
> mplayer -speed 3 movie.avi
> mplayer segfaults and there is an oops in the logs
> 
> The above command line plays the movie at a speed above normal. It happens
> for any value of speed > 1.
> 
> It's 100% reproductible. It oopses with any media file (an mp3 file for
> example), and with kernel 2.6.4 and 2.6.5rc2.
> Kernels 2.6.2 and 2.6.3 work fine.

I cannot reproduce here - gcc 3.3.1 (SuSE), 2.6.4. It seems that you
trigger the gcc bug. Try enable CONFIG_FRAME_POINTER in your kernel and
let me know, if it helps.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
