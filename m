Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbUCRTm5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 14:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbUCRTm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 14:42:57 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:49797
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262897AbUCRTmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 14:42:55 -0500
Date: Thu, 18 Mar 2004 20:43:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, mjy@geizhals.at,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-ID: <20040318194345.GD2022@dualathlon.random>
References: <40591EC1.1060204@geizhals.at> <20040318060358.GC29530@dualathlon.random> <s5hlllycgz3.wl@alsa2.suse.de> <20040318110159.321754d8.akpm@osdl.org> <s5hd67ac6r8.wl@alsa2.suse.de> <20040318111807.7fa62340.akpm@osdl.org> <s5had2ec68e.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5had2ec68e.wl@alsa2.suse.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 08:20:17PM +0100, Takashi Iwai wrote:
> also, the total buffer underrun/overrun problem doesn't happen *so*
> often (except for the heavy i/o load, etc).

you mean because the disk has not enough bandwidth to read the file,
right? (not scheduler related)
