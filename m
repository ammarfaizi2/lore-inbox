Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbUCRTSL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 14:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbUCRTSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 14:18:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:55775 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262890AbUCRTSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 14:18:07 -0500
Date: Thu, 18 Mar 2004 11:18:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: andrea@suse.de, mjy@geizhals.at, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-Id: <20040318111807.7fa62340.akpm@osdl.org>
In-Reply-To: <s5hd67ac6r8.wl@alsa2.suse.de>
References: <40591EC1.1060204@geizhals.at>
	<20040318060358.GC29530@dualathlon.random>
	<s5hlllycgz3.wl@alsa2.suse.de>
	<20040318110159.321754d8.akpm@osdl.org>
	<s5hd67ac6r8.wl@alsa2.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> wrote:
>
> oh, sorry, maybe i forgot to tell you that it has been already there
>  :)
> 
>  	# echo 1 > /proc/asound/card0/pcm0p/xrun_debug
> 
>  this will show the stacktrace when a buffer overrun/underrun is
>  detected in the irq handler.  it's not perfect, though.

heh, you just shrunk my todo list by 0.01%.

Have you had any useful reports from this feature?
