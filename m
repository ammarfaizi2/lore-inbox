Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbUKOOJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbUKOOJe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 09:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUKOOJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 09:09:34 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:1217 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261599AbUKOOJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 09:09:30 -0500
To: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPU hogs ignoring SIGTERM (unkillable processes)
References: <4198A766.28114.106DD7B@rkdvmks1.ngate.uni-regensburg.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: And furthermore, my bowling average is unimpeachable!!!
Date: Mon, 15 Nov 2004 14:39:22 +0100
In-Reply-To: <4198A766.28114.106DD7B@rkdvmks1.ngate.uni-regensburg.de> (Ulrich
 Windl's message of "Mon, 15 Nov 2004 12:56:05 +0100")
Message-ID: <jebrdzz0xh.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:

> Hello,
>
> today I've discovered a programming error in one of my programs (that's fixed 
> already). When trying to replace the binary, I found out that the processes seem 
> unaffected by a plain "kill": They just continue to consume CPU. However, a "kill 
> -9" terminates them. ist that intended behavior? I guess not. Here are some facts:

Are you sure it doesn't block or ignore the signal?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
