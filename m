Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbTFDKsZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 06:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbTFDKsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 06:48:24 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:11786 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263195AbTFDKsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 06:48:23 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: -rc7   Re: Linux 2.4.21-rc6
Date: Wed, 4 Jun 2003 13:01:02 +0200
User-Agent: KMail/1.5.2
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva> <200306041235.07832.m.c.p@wolk-project.de> <20030604104304.GQ3412@x30.school.suse.de>
In-Reply-To: <20030604104304.GQ3412@x30.school.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306041301.02676.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 June 2003 12:43, Andrea Arcangeli wrote:

Hi Andrea,

> sure, it's just a matter of adding a bit to the blkdev structure.
> However I'm not 100% sure that it is the real thing that could make the
> difference, but overall the exclusive wakeup FIFO in theory should
> provide even an higher degree of fariness, so at the very least the
> "fix" 2 from Andrew makes very little sense to me, and it seems just an
> hack meant to hide a real problem in the algorithm.
well, at least it reduces pauses/stops ;)

> As for 1 and 3 they were just included in my tree for ages.
err, 1 yes, but I don't see that 3 is in your tree. Well, ok, a bit different. 
But hey, your 1+3 are still having pauses ;)

> BTW, Chris recently spotted a nearly impossible to trigger SMP-only race
> in the fix pausing patch [great spotting Chris] (to trigger it would
Cool Chris!

> need an intersection of two races at the same time), it'll be fixed in
> my next tree, however nobody ever reproduced it and you certainly can
> ignore it in practice so it can't explain any issue.
Good to know. Thanks.

ciao, Marc

