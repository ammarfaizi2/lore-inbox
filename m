Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262875AbUKYBIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262875AbUKYBIL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 20:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbUKYBIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 20:08:11 -0500
Received: from 63-239-138-134.cust.qwest.net ([63.239.138.134]:50577 "EHLO
	beast.netrics.com") by vger.kernel.org with ESMTP id S262875AbUKYBIG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 20:08:06 -0500
To: linux-kernel@vger.kernel.org
From: Eric Sharkey <sharkey@netrics.com>
X-Eric-Conspiracy: There is no conspiracy
Subject: Re: Audio problems on AMD64 with Via K8T800 chipset 
In-reply-to: Your message of "Wed, 24 Nov 2004 10:12:24 EST."
Date: Wed, 24 Nov 2004 20:08:05 -0500
Message-Id: <E1CX87B-00086I-00@mastermind.netrics.internal>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2004-11-24 at 14:36:48 EST Lee Revell wrote:

> This may have already been covered on the alsa list, but...
> 
> Have any of you tried the OSS drivers?

I've just tried the OSS Trident driver.  It sounds different.

I'm still getting noticable audio dropouts in bumprace.  Timidity
sounds ok, now.  Other apps sound, oh, I don't know, scratchy is the
best word, I guess.  It's almost as if the dropouts are occuring
more frequently (much more frequently) but with shorter duration,
making it sound like scratchy sound rather than sound with punctuated
silence as it did under Alsa.

Maybe some sort of interrupt handling problem not getting the bits
where they need to be at the right time?

Eric
