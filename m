Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267168AbTGGTYz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 15:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267169AbTGGTYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 15:24:55 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:41356 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S267168AbTGGTYx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 15:24:53 -0400
Date: Mon, 7 Jul 2003 20:39:11 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Daniel Phillips <phillips@arcor.de>, Mel Gorman <mel@csn.ul.ie>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: 2.5.74-mm1
Message-ID: <20030707193911.GB10836@mail.jlokier.co.uk>
References: <20030703023714.55d13934.akpm@osdl.org> <20030707152339.GA9669@mail.jlokier.co.uk> <Pine.LNX.4.55.0307071007140.4704@bigblue.dev.mcafeelabs.com> <200307071955.58774.phillips@arcor.de> <Pine.LNX.4.55.0307071105110.4704@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307071105110.4704@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> Try to play with SNDCTL_DSP_SETFRAGMENT. Last time I checked the kernel
> let you set a dma buf for 0.5 up to 1 sec of play (upper limited by 64Kb).
> Feeding the sound card with 4Kb writes will make you skip after about 50ms
> CPU blackout at 44KHz 16 bit. RealPlayer uses 16Kb feeding chunks that
> makes it able to sustain up to 200ms of blackout.

Large buffers are fine for streaming, provided you aren't sliding the
volume or graphic equaliser.  I find xmms annoying in this regard: I
adjust the eq and wait some absurd length of time (fully tenths of a
second :) to hear the feedback.

Large buffers are useless for games or telephony.

-- Jamie
