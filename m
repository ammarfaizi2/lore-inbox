Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWJEUJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWJEUJa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWJEUJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:09:30 -0400
Received: from centrmmtao03.cox.net ([70.168.83.81]:55699 "EHLO
	centrmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751188AbWJEUJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:09:29 -0400
Subject: Re: Free memory level in 2.6.16?
From: Steve Bergman <sbergman@rueb.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <p73k63ezg3y.fsf@verdi.suse.de>
References: <1160034527.23009.7.camel@localhost>
	 <p73k63ezg3y.fsf@verdi.suse.de>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 15:10:29 -0500
Message-Id: <1160079029.29452.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 22:01 +0200, Andi Kleen wrote:

> 
> Normally it keeps some memory free for interrupt handlers which
> cannot free other memory. But 150MB is indeed a lot, especially
> it's only in the ~900MB lowmem zone.
> 
> You could play with /proc/sys/vm/lowmem_reserve_ratio but must
> likely some defaults need tweaking.

Thank you for the reply, Andi.  This kernel is compiled with the .config
from the original FC5 release, which used kernel 2.6.15.  I just ran
"make oldconfig" on it and accepted the defaults.

So it is, I believe, a 4GB/4GB split.  Does that make a difference?

Thanks,
Steve Bergman

