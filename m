Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUEJApT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUEJApT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 20:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264439AbUEJApT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 20:45:19 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:24257 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S264430AbUEJApG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 20:45:06 -0400
Date: Sun, 9 May 2004 20:45:28 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Alexey Mahotkin <alexm@w-m.ru>
Subject: Re: [PATCH][2.6] throttle P4 thermal warnings
In-Reply-To: <20040506134506.GB241@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0405092034480.1896@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0404300952350.2332@montezuma.fsmlabs.com>
 <20040506134506.GB241@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2004, Pavel Machek wrote:

> Hi!
>
> > In really bad conditions this can keep printing for a while, throttle the
> > output somewhat. Also change the "CPU%d" formatting to better match the
> > other boot output.
>
> Hmm, is it possible that you see "temperature above treshold", but
> then you throttle it so you never see "temperature normal" message?
>
> That would be pretty bad...

Well i went for the avoid overwhelming the user with messages option and
wanted as little code as possible, this isn't really supposed to be that
smart, more of a "Warning, things may go pear shaped fairly soon"

> Also please consider putting Temperature above threshold and running
> in modulated clock mode on single line.

Ok i'll work your requests into a patch, there are some other changes i
have queued for later too.

Thanks,
	Zwane

