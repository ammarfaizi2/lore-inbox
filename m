Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUCSWNJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 17:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263127AbUCSWNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 17:13:08 -0500
Received: from peabody.ximian.com ([130.57.169.10]:27025 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S263101AbUCSWNE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 17:13:04 -0500
Subject: Re: CONFIG_PREEMPT and server workloads
From: Robert Love <rml@ximian.com>
To: Valdis.Kletnieks@vt.edu
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>,
       andrea@suse.de, mjy@geizhals.at, linux-kernel@vger.kernel.org
In-Reply-To: <200403192203.i2JM3nSN016646@turing-police.cc.vt.edu>
References: <40591EC1.1060204@geizhals.at>
	 <20040318060358.GC29530@dualathlon.random> <s5hlllycgz3.wl@alsa2.suse.de>
	 <20040318110159.321754d8.akpm@osdl.org> <s5hd67ac6r8.wl@alsa2.suse.de>
	 <1079637899.6363.8.camel@localhost>
	 <200403192203.i2JM3nSN016646@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1079734375.14039.106.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Fri, 19 Mar 2004 17:12:55 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is one of these yours?  My machine has 3 (but only one soundcard) ;)
> 
> %  find /proc/asound/ -name xrun_debug -ls
>   4480    0 -r--r--r--   1 root     root            0 Mar 19 16:00 /proc/asound/card0/pcm1c/xrun_debug
>   4470    0 -r--r--r--   1 root     root            0 Mar 19 16:00 /proc/asound/card0/pcm0c/xrun_debug
>   4462    0 -r--r--r--   1 root     root            0 Mar 19 16:00 /proc/asound/card0/pcm0p/xrun_debug
> 
> (Are these 3 different controls, or 3 places to set the same variable?)

Heh :)

I suspect I need debugging enabled.

	Robert Love


