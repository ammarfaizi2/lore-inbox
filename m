Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264960AbUHWSG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbUHWSG6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUHWSG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:06:58 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:62945 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S264960AbUHWSFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:05:02 -0400
Date: Mon, 23 Aug 2004 14:09:20 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, Thomas Charbonnel <thomas@undata.org>
Subject: Re: [PATCH] Fix shared interrupt handling of SA_INTERRUPT and
 SA_SAMPLE_RANDOM
In-Reply-To: <s5hd61hhifg.wl@alsa2.suse.de>
Message-ID: <Pine.LNX.4.58.0408231407420.13924@montezuma.fsmlabs.com>
References: <s5heklxhjbg.wl@alsa2.suse.de> <s5hd61hhifg.wl@alsa2.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004, Takashi Iwai wrote:

> At Mon, 23 Aug 2004 19:10:11 +0200,
> I wrote:
> >
> > The patch below fixes these problems by adding the SA_INTERRUPT
> > handler always to the head of the irq list, and by checking the return
> > value of each handler.
>
> Forgot to mention that it's to 2.6.8.1.

I recall Andrea having it in his 2.4 tree ages ago, i'm not quite sure why
it didn't get pushed.
