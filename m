Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264660AbUDVTwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264660AbUDVTwG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 15:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264650AbUDVTut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 15:50:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:9167 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264654AbUDVTuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 15:50:12 -0400
Date: Tue, 20 Apr 2004 21:40:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Zoltan.Menyhart@bull.net
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Dynamic System Calls & System Call Hijacking
Message-ID: <20040420194016.GF1413@openzaurus.ucw.cz>
References: <4084E85E.4722BFC6@nospam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4084E85E.4722BFC6@nospam.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> - Can't recompile the kernel, otherwise you gonna lose RedHat guarantee ?
>   Or some ISVs like whose name starts with an "O" and terminates with "racle"
>   ain't gonna support it ?
 
>   + No problem, I'll load your syscall in a module.

Well, by forcing syscall in, you loose your guarantee, too.
cat /dev/urandom > /dev/kmem

"RedHat, help, my machine crashed."


> Your remarks will be appreciated.

I hope it at least taints the kernel.

And you did test on smp kernel, trying to race syscall calling against
your module load/unload, right?

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

