Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbUCRTZQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 14:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUCRTZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 14:25:15 -0500
Received: from peabody.ximian.com ([130.57.169.10]:62442 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262901AbUCRTZK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 14:25:10 -0500
Subject: Re: CONFIG_PREEMPT and server workloads
From: Robert Love <rml@ximian.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de, mjy@geizhals.at,
       linux-kernel@vger.kernel.org
In-Reply-To: <s5hd67ac6r8.wl@alsa2.suse.de>
References: <40591EC1.1060204@geizhals.at>
	 <20040318060358.GC29530@dualathlon.random> <s5hlllycgz3.wl@alsa2.suse.de>
	 <20040318110159.321754d8.akpm@osdl.org>  <s5hd67ac6r8.wl@alsa2.suse.de>
Content-Type: text/plain
Message-Id: <1079637899.6363.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Thu, 18 Mar 2004 14:24:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 14:08, Takashi Iwai wrote:

> oh, sorry, maybe i forgot to tell you that it has been already there
> :)
> 
> 	# echo 1 > /proc/asound/card0/pcm0p/xrun_debug
> 
> this will show the stacktrace when a buffer overrun/underrun is
> detected in the irq handler.  it's not perfect, though.

Excellent!

Has this resulted in anything useful?

With KALLSYMS=y, a lot of users now become intelligent bug testers.

Eh, except that I do not have that procfs entry on my system..

	Robert Love


