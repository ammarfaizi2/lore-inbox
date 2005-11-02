Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbVKBFHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbVKBFHp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 00:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbVKBFHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 00:07:45 -0500
Received: from [203.171.93.254] ([203.171.93.254]:13455 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1751501AbVKBFHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 00:07:44 -0500
Subject: Re: [PATCH 2.6.14-rc1-git5] sched: disable preempt in idle tasks
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ian Molton <spyro@f2s.com>
In-Reply-To: <43682878.3040800@yahoo.com.au>
References: <59D45D057E9702469E5775CBB56411F1C19A01@pdsmsx406>
	 <43682878.3040800@yahoo.com.au>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1130907843.3853.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 02 Nov 2005 16:04:04 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick.

On Wed, 2005-11-02 at 13:46, Nick Piggin wrote:
> Hi Shaohua,
> 
> Li, Shaohua wrote:
> 
> > 
> > What's the status of the patch? I didn't see it in base kernel.
> > We found another bug related with this issue. On UP system, if a CPU
> > enters 
> > 'mwait_idle', it never leaves it, as the 'mwait_idle' loop will never
> > end.
> > Disabling preempt fixes the bug. Should I submit a patch just disabling
> > preempt in 'mwait_idle' or wait for your patch?
> > 
> 
> The patch is in Andrew's tree, and it should get merged for 2.6.15.
> If you have verified that disabling preempt in mwait_idle fixes the
> bug, then you may like to send that to the 2.6.14.stable guys.

I sent an email a couple of weeks ago saying that it looked like it did
the trick for me - no problems in two weeks of testing. (I would have
easily seen it within a day or two prior to this).

Regards,

Nigel

> Thanks,
> Nick
-- 


