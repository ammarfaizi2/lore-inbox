Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264782AbUFGPPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264782AbUFGPPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 11:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUFGPOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 11:14:21 -0400
Received: from loki.snap.net.nz ([202.37.101.41]:48402 "EHLO loki.snap.net.nz")
	by vger.kernel.org with ESMTP id S264788AbUFGPML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 11:12:11 -0400
Date: Tue, 8 Jun 2004 03:19:50 +1200 (NZST)
From: Keith Duthie <psycho@albatross.co.nz>
To: Sebastian Kloska <kloska@scienion.de>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: APM realy sucks on 2.6.x
In-Reply-To: <40C47FEE.6080505@scienion.de>
Message-ID: <Pine.LNX.4.53.0406080314460.27816@loki.albatross.co.nz>
References: <40C0E91D.9070900@scienion.de> <20040607123839.GC11860@elf.ucw.cz>
 <40C46F7F.7060703@scienion.de> <Pine.LNX.4.53.0406080228110.27816@loki.albatross.co.nz>
 <40C47FEE.6080505@scienion.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2004, Sebastian Kloska wrote:

>   Does this bug freeze the machine ? Or just block
>   the outputting program ?

The machine remains completely usable except for sound; the outputting
program is stuck in uninterruptible sleep, and hence is unkillable. I've
dug up my patch (which is against 2.6.5, but should patch cleanly with any
other 2.6, as it's merely a one liner), and will submit it in a separate
email.

-- 
Just because it isn't nice doesn't make it any less a miracle.
     http://users.albatross.co.nz/~psycho/     O-   -><-
